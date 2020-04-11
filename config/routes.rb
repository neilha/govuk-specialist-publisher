Rails.application.routes.draw do
  mount GovukAdminTemplate::Engine, at: "/style-guide"
  resources :documents do
    resources :attachments
  end
  root 'documents#index'
end
