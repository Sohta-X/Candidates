class Admin::PagesController < Admin::BaseController
  def setting
    render layout: 'no_sidebar'
  end
end
