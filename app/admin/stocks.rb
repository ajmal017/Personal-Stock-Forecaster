ActiveAdmin.register Stock do
  action_item :only => :index do
    link_to 'Update Quotes', fetch_quotes_admin_stocks_path
  end

  action_item :only => :index do
    link_to 'Generate Predictions', generate_predictions_admin_stocks_path
  end

  collection_action :fetch_quotes do
    respond_to do |format|
      if Stock.fetch_all_quotes
        format.html { redirect_to admin_stocks_url, notice: 'Stock quotes have been updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_stocks_url, alert: 'There has been some problem with fetching quotes, try again later.' }
        format.json { head :no_content }
      end
    end
  end

  collection_action :generate_predictions do
    Stock.generate_predictions
    respond_to do |format|
      format.html { redirect_to admin_stocks_url, notice: 'Predictions have been generated for Stocks.' }
      format.json { head :no_content }
    end
  end

  index do
    column "Stock ID", :stock_id, :sortable => :stock_id do |stock|
      link_to stock.stock_id, admin_stock_path(stock)
    end
    column "Company", :name
    column :created_at
    default_actions
  end

  show title: :name do
    attributes_table do
      row :id
      row "Stock ID" do
        stock.stock_id
      end
      row "Company" do
        stock.name
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      f.input :stock_id, label: "Stock ID"
      f.input :name, label: "Company"
    end
    f.buttons
  end

end