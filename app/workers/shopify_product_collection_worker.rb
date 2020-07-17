require 'rubygems'
require 'uri'
require 'shopify_product_collection_worker'
class ShopifyProductCollectionWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  JOB_NAME = "ShopifyProductCollectionJob"

  def perform()
    fetch_products
  end

  def fetch_products
    puts "starting shopify product pull"
    Sidekiq.logger.info "Hello there starting ShopifyProductCollectionJob!"
    Product.destroy_all
    ProductVariant.destroy_all
    shop_url = "https://#{ENV["API_KEY"]}:#{ENV["PASSWORD"]}@#{ENV["SHOP_NAME"]}.myshopify.com"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = '2019-10'
    products = ShopifyAPI::Product.find(:all, params: { limit: 250 })
    process_products(products)
    # while products.next_page?
    #   products = products.fetch_next_page
      process_products(products)
    # end
    puts "All done with products"
  end
  def process_products products
    products.each do |myprod|
      puts "----------- #{myprod.inspect}"
      myprodid = myprod.attributes['id']
      myprodtitle = myprod.attributes['title']
      myprod_type = myprod.attributes['product_type']
      mycreated_at = myprod.attributes['created_at']
      myupdated_at = myprod.attributes['updated_at']
      myhandle = myprod.attributes['handle']
      mytemplate_suffix = myprod.attributes['template_suffix']
      mybody_html = myprod.attributes['body_html']
      mytags = myprod.attributes['tags']
      mypublished_scope = myprod.attributes['published_scope']
      myvendor = myprod.attributes['vendor']
      myoptions = myprod.attributes['options'][0].attributes
      myimages_array = Array.new
      myprod.attributes['images'].each do |mystuff|
        myimages_array << mystuff.attributes
      end
      puts myimages_array.inspect
      product = Product.create(title: myprodtitle, product_type: myprod_type, created_at: mycreated_at, updated_at: myupdated_at, handle: myhandle, template_suffix: mytemplate_suffix, body_html: mybody_html, tags: mytags, published_scope: mypublished_scope, vendor: myvendor, options: myoptions, image: myimages_array)


      myvariants = myprod.variants
      myvariants.each do |myvar|
        puts "++++++++++++"
        puts myvar.attributes.inspect
        puts myvar.prefix_options[:product_id]
        puts "++++++++++++"
        myproduct_id = myvar.prefix_options[:product_id]
        myvariant_id = myvar.attributes['id']
        mytitle = myvar.attributes['title']
        myprice = myvar.attributes['price']
        mysku = myvar.attributes['sku']
        myposition = myvar.attributes['position']
        myinventory_policy = myvar.attributes['inventory_policy']
        mycompare_at_price = myvar.attributes['compare_at_price']
        myfulfillment_service = myvar.attributes['fulfillment_service']
        myinventory_management = myvar.attributes['inventory_management']
        myoption1 = myvar.attributes['option1']
        myoption2 = myvar.attributes['option2']
        myoption3 = myvar.attributes['option3']
        mycreated_at = myvar.attributes['created_at']
        myupdated_at = myvar.attributes['updated_at']
        mytaxable = myvar.attributes['taxable']
        mybarcode = myvar.attributes['barcode']
        myweight_unit = myvar.attributes['weight_unit']
        myweight = myvar.attributes['weight']
        myinventory_quantity = myvar.attributes['inventory_quantity']
        myimage_id = myvar.attributes['image_id']
        mygrams = myvar.attributes['grams']
        myinventory_item_id = myvar.attributes['inventory_item_id']
        mytax_code = myvar.attributes['tax_code']
        myold_inventory_quantity = myvar.attributes['old_inventory_quantity']
        myrequires_shipping = myvar.attributes['requires_shipping']
        ProductVariant.create(variant_id: myvariant_id, shopify_product_id: myproduct_id, title: mytitle, price: myprice, sku: mysku, position: myposition, inventory_policy: myinventory_policy, compare_at_price: mycompare_at_price, fulfillment_service: myfulfillment_service, inventory_management: myinventory_management, option1: myoption1, option2: myoption2, option3: myoption3, created_at: mycreated_at, updated_at: myupdated_at, taxable: mytaxable, barcode: mybarcode, weight_unit: myweight_unit, weight: myweight, inventory_quantity: myinventory_quantity, image_id: myimage_id, grams: mygrams, inventory_item_id: myinventory_item_id, tax_code: mytax_code, old_inventory_quantity: myold_inventory_quantity, requires_shipping: myrequires_shipping, product_id: product.id, product_vendor: myvendor  )

      end
      puts "-----------"
      wait_for_shopify_credits
    end
  end
  def fetch_collections
    put collects and custom collection here
    collect_count = ShopifyAPI::Collect.count
    puts "We have #{collect_count} collects"

    page_size = 250
    pages = (collect_count / page_size.to_f).ceil

    ShopifyCollect.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('shopify_collects')

    1.upto(pages) do |page|
      mycollects = ShopifyAPI::Collect.find(:all, params: {limit: 250, page: page})
      #puts mycollects.inspect
      mycollects.each do |myc|
        puts myc.attributes.inspect
        my_local_collect = ShopifyCollect.create(collect_id: myc.attributes['id'], collection_id: myc.attributes['collection_id'], product_id: myc.attributes['product_id'], featured: myc.attributes['featured'], created_at: myc.attributes['created_at'], updated_at: myc.attributes['updated_at'], position: myc.attributes['position'], sort_value: myc.attributes['sort_value'] )

      end
      puts "------------------"
      puts "Done with page #{page}"
      wait_for_shopify_credits

    end
    puts "Done with collects"
  end

  def wait_for_shopify_credits
    if ShopifyAPI::credit_left < 4
      puts "sleeping for 10 seconds to obtain credits..."
      sleep(10)
    else
      puts "credit limit left #{ShopifyAPI::credit_left}"
    end
  end


end