module UsersHelper
  ##
  # Includes functions related to users
  ##
  # Set devise_mapping for devise so that we can call the devise help links (views/devise/shared/_links) from anywhere (eg sign_up form in proposals#new)
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def omniauth_configured
    providers = []
    Devise.omniauth_providers.each do |provider|
      provider_key = "#{provider}_key"
      provider_secret = "#{provider}_secret"
      unless Rails.application.secrets.send(provider_key).blank? || Rails.application.secrets.send(provider_secret).blank?
        providers << provider
      end
      providers << provider if !ENV["OSEM_#{provider.upcase}_KEY"].blank? && !ENV["OSEM_#{provider.upcase}_SECRET"].blank?
    end

    return providers.uniq
  end

end
