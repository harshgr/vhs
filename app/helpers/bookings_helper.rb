module BookingsHelper
  def price(pick_up_date ,drop_date ,cost_per_day )
        
        days = (drop_date.to_date - pick_up_date.to_date).to_i
        days = days +1
        total_cost = (days * cost_per_day )
  end
end
