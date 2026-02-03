class CrawlersController < ApplicationController
  WEB_URL = 'https://ptpsr.uhc.com/prweb/CRExternal/ve_AdGnzk0tVEkWf1tHNZHTq26F5ROOf*/!TABTHREAD0?pyActivity=doUIAction&preActivity=RemovePages&preActivityParams=%3A&action=display&harnessName=CorporateInfo&className=UHG-FW-SRFW-Registration&model=&frameName=Search&readOnly=false'
  
  USER_EMAIL = 'spatel150'
  USER_PASS = 'Sainath12'


  def scrap_the_web
    row = Crawler.create(raw: t('crawler.wait_message'))
    
    status = Delayed::Job.enqueue Crawl.new(WEB_URL, USER_EMAIL, USER_PASS, row)

    if status 
      redirect_to show_response_crawlers_url
    
    else
      render json: t('crawler.process_unsuccessful')
    end
  end


  def show_response
    @response = Crawler.last
  end
end