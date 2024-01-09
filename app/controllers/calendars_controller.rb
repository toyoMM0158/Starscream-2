class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def getWeek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']


    @todays_date = Date.today
    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)
    
    7.times do |x|
      date = @todays_date + x
      today_plans = plans.select { |plan| plan.date == date }.map(&:plan)
      wday_num = date.wday # wdayメソッドを用いて取得した数値
    
      if wday_num >= 7
        wday_num -= 7 # wday_numが7以上の場合は7を引いて調整
      end
    
      days = {
        month: date.month,
        date: date.day,
        plans: today_plans,
        wday: wdays[wday_num] # wdaysから取り出した曜日の要素を代入
      }
      @week_days.push(days)
      
    end

  end
end