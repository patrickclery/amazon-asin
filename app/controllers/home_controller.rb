# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render component: "App", layout: "application", prerender: false
  end
end
