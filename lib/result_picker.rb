# Result picker was designed to simply yield return value before the block ends
# My own use case was returning model built inside transaction, which could be rolled back
# because it was invalid. Normally, solution is
#   x = nil
#   something do
#     stuff
#     x = value
#     more_stuff
#   end
#   x
# which is ugly. The better idea is to wrap this stuff inside one of your methods
# e.g. `synchronize`, `transaction`, and this class allows you to DRY
#
# Usage:
#   ResultPicker.pick! do |result_picker|
#     something do
#       stuff
#       result_picker.call value
#       more_stuff
#     end
#   end
class ResultPicker
  VERSION = "0.1.0"
  # result attribute writer have the same semantic as lambda and can be used in same cases
  attr_writer :result

  # @param [bool] strict if strict is true, method will raise exception if lambda would never be called
  # @return [Object] anything passed to lambda or result of yield
  # @raise [ArgumentError] if no block given
  # This is all in one method which will pass lambda into the block and then execute it,
  # assuming this is default value to return if lambda would not be called inside
  def self.pick(strict = false)
    raise ArgumentError, 'block not given' unless block_given?
    picker = new
    x = yield picker.lambda
    strict ? picker.result! : picker.result(x)
  end

  # @param [Proc] block which would be passed to pick
  # @return [Object] anything passed to lambda
  # @raise [ResultNotGiven] if lambda was not called
  # @raise [ArgumentError] if no block given
  # This is all in one method which will pass lambda into the block and then execute it
  def self.pick!(&block)
    pick(true, &block)
  end

  # @return [Proc] a lambda, which could be called to store parameter in a result picker
  def lambda
    context = self
    -> (x) { context.result = x }
  end

  # @return [bool] true or false, depending if labmda was called
  def result_given?
    defined?(@result)
  end

  # @param [Object] default default value, which would be returned if labmda was not called
  # @return [Object] stored result
  def result(default = nil)
    return default unless result_given?
    @result
  end

  # @raise [ResultNotGiven] if lambda was not called
  # @return [Object] stored result
  def result!
    raise ResultNotGiven unless result_given?
    @result
  end
end
