# -*- encoding: utf-8 -*-
class Admin::BaseController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
end
