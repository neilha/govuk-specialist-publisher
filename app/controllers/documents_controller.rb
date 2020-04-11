class DocumentsController < ApplicationController
    include ActionView::Context
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper

    before_action :fetch_document, except: %i[index new create]

    def index
        @documents = Document.all
        @query = params[:query]
    end 

    def new
        @document = Document.new
    end
    
    def create
        @document = Document.new(document_params)

        if @document.save
            flash[:success] = "Created #{@document.title}"
            redirect_to @document
        elsif @document.errors.any?
            flash.now[:errors] = document_error_messages
            render :new, status: 422
        else
          flash.now[:danger] = unknown_error_message
          render :new            
        end
    end

    def show
        # if @document.content_item_blocking_publish?
        #   flash[:danger] = "Warning: This document's URL is already used on GOV.UK. You can't publish it until you change the title."
        # end
    end  
    
    def edit; end

    def update
      # @document.set_attributes(document_params)
  
      # if @document.valid?
      #   if @document.save
      #     flash[:success] = "Updated #{@document.title}"
      #     redirect_to document_path(@document)
      #   else
      #     flash.now[:danger] = unknown_error_message
      #     render :edit
      #   end
      @document = Document.find(params[:id])

      if @document.update(document_params)
        redirect_to @document
      else
        flash.now[:errors] = document_error_messages
        render :edit, status: 422
      end
    end    

    private
        def document_params
            params.require(:document).permit(:title, :summary, :body, :publication_state)
        end    

        def unknown_error_message
          support_url = "https://support.gov.uk/technical_fault_report/new"
      
          "Something has gone wrong. Please try again and see if it works. <a href='#{support_url}'>Let us know</a>
          if the problem happens again and a developer will look into it.".html_safe
        end        

        def document_error_messages
            @document.errors.messages
            heading = content_tag(
              :h4,
              %{
                Please fix the following errors
              },
            )
            errors = content_tag :ul, class: "list-unstyled remove-bottom-margin" do
              list_items = @document.errors.full_messages.map do |message|
                content_tag(:li, message.html_safe)
              end
              list_items.join.html_safe
            end
        
            heading + errors
        end
        
        def fetch_document
            @document = Document.find(params[:id])
        #   rescue DocumentFinder::RecordNotFound => e
        #     flash[:danger] = "Document not found"
        #     redirect_to documents_path(document_type_slug: document_type_slug)
        
        #     GovukError.notify(e)

          rescue ActiveRecord::RecordNotFound => e
            flash[:danger] = "Document not found"
            redirect_to documents_path
        end        
end
