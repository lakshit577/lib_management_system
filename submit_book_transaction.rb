class SubmitBookTransaction

    attr_accessor :return_date, :qty
  
    def initialize(return_date, qty)
      @return_date = return_date
      @qty = qty
    end
    
end