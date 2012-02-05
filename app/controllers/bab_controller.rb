# encoding : UTF-8
class BabController < ApplicationController
  def index
    
  end
  def main

    @taste_restaurants = Restaurant.order('tastepoint/count desc limit 5')
    @speed_restaurants = Restaurant.order('speedpoint/count desc limit 5')
    @amount_restaurants = Restaurant.order('amountpoint/count desc limit 5')
    @service_restaurants = Restaurant.order('servicepoint/count desc limit 5')

    @new_restaurants = Restaurant.order('created_at desc limit 3')

    @new_evaluations = Evaluation.order('created_at desc limit 3')
    render :layout => nil
  end  
  def view_res
    @restaurant = Restaurant.find(params[:res_id])
    @ev_temps = Evaluation.find(:all, :order => "created_at desc", :conditions => ['restaurant_id = ?', params[:res_id]], :limit => 3)
    @menus = Menu.where(:restaurant_id => params[:res_id])
    @menu_view_res = @menus.sort_by{"|m| (m.like-m.dislike)"}.first(1)
    @menus_all = []
    @menus.each do |m|
      menu = {}
      goodbad = {}
      menu['menu'] = m
      @goodbad = m.goodbads.first(:conditions => ['user_id = ?', session[:user_id]])
      menu['goodbad'] = @goodbad
      @menus_all << menu

    end

      render :layout => false

  end


  def search
    if params[:search].nil?
      @results = Restaurant.find(:all).paginate(:page => params[:page], :per_page => 4)
    else
      @results = Restaurant.where('resname LIKE ? ',"%#{params[:search]}%").paginate(:page => params[:page], :per_page => 4)
    end
      render :layout => false
  end

  def select

    render :layout => false
  end
  def today_res
    date = Time.now.year.to_s + Time.now.month.to_s + Time.now.day.to_s

    r = Recommendation.find_by_date(date)

    if r.nil?
      if (Restaurant.count == 0)
      index = 1
      else
      index = Restaurant.count
      end
      res_id = rand(index) + 1
      new_r = Recommendation.new
      new_r.date = date
      new_r.res_id = res_id
      new_r.save
      @today_res = Restaurant.find(res_id)
    else
      @today_res = Restaurant.find(r.res_id)
    end
    @today_menus = Menu.where(:restaurant_id => @today_res.id)
    @menu_today_res = @today_menus.sort_by{"|m| (m.like-m.dislike)"}.first(1)




    render :layout => false
  end

  def select_result
########################################select type##
    @selected = []
    if (params[:chinese] == "1")
      @selected.concat(Restaurant.where('restype = ? ' , '중식'))
    end
    if (params[:pizza] == "1")
      @selected.concat(Restaurant.where('restype = ?', '피자'))
    end
    if (params[:chicken] == "1")
      @selected.concat(Restaurant.where('restype = ?', '치킨'))
    end
    if (params[:dosirak] == "1")
      @selected.concat(Restaurant.where('restype = ?', '도시락'))
    end
    if (params[:etc] == "1")
      @selected.concat(Restaurant.where('restype = ?', '기타'))
    end
    if (@selected.count == 0)
      @selected.concat(Restaurant.all)
    end
######################################################
############################priority select###########
   p1 = params[:priority_1] 
   p2 = params[:priority_2] 
   p3 = params[:priority_3] 
   p4 = params[:priority_4]


     
    if (params["#{p1}_level"] == "0")
      filtering_1 = @selected.sort_by{"|f1| (f1.#{p1}point/f1.count)"}.first(10)
    elsif (params["#{p1}_level"] == "1")
      filtering_1 = @selected.sort_by{"|f1| f1.count"}.first(10)
    elsif (params["#{p1}_level"] == "2")
      filtering_1 = @selected.sort_by{"|f1| -(f1.#{p1}point/f1.count)"}.first(10)
    end 
    if (params["#{p2}_level"] == "0")
      filtering_2 = filtering_1.sort_by{"|f1| (f1.#{p2}point/f1.count)"}.first(7)
    elsif (params["#{p2}_level"] == "1")
      filtering_2 = filtering_1.sort_by{"|f1| f1.count"}.first(7)
    elsif (params["#{p2}_level"] == "2")
      filtering_2 = filtering_1.sort_by{"|f1| -(f1.#{p2}point/f1.count)"}.first(7)
    end 
    if (params["#{p3}_level"] == "0")
      filtering_3 = filtering_2.sort_by{"|f1| (f1.#{p3}point/f1.count)"}.first(5)
    elsif (params["#{p3}_level"] == "1")
      filtering_3 = filtering_2.sort_by{"|f1| f1.count"}.first(5)
    elsif (params["#{p3}_level"] == "2")
      filtering_3 = filtering_2.sort_by{"|f1| -(f1.#{p3}point/f1.count)"}.first(5)
    end 
    if (params["#{p4}_level"] == "0")
      filtering_4 = filtering_3.sort_by{"|f1| (f1.#{p4}point/f1.count)"}.first(3)
    elsif (params["#{p4}_level"] == "1")
      filtering_4 = filtering_3.sort_by{"|f1| f1.count"}.first(3)
    elsif (params["#{p4}_level"] == "2")
      filtering_4 = filtering_3.sort_by{"|f1| -(f1.#{p4}point/f1.count)"}.first(3)
    end 
######################################################
    @final_sel = filtering_4.sample
    @final_menus = Menu.where(:restaurant_id => @final_sel.id)
    @menu_final_res = @final_menus.sort_by{"|m| (m.like-m.dislike)"}.first(1)
    render :layout => false
  end




end
