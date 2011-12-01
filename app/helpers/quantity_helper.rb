module QuantityHelper

  # Format a quantity float value.
  def format_quantity(quantity)
    number_with_precision(quantity, :strip_insignificant_zeros => true, :precision => 2)
  end

end
