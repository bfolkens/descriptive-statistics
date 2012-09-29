class DescriptiveStatistics
  module CentralTendency
    def sum
      inject(0, :+)
    end

    def mean
      return if length < 1
      sum / length.to_f
    end

    def median
      return if length < 1
      sorted = self.sort

      if length % 2 == 0
        (sorted[(length/2) -1 ] + sorted[length / 2]) / 2.0
      else
        sorted[length / 2]
      end
    end

    def mode
      return if length < 1
      frequency_distribution = each_with_object(Hash.new(0)) { |value, hash| hash[value] += 1 }
      top_2 = frequency_distribution.sort { |a,b| b[1] <=> a[1] } .take(2)
      if top_2.length == 1
        top_2.first.first # Only one value in distribution, so it's the mode.
      elsif top_2.first.last == top_2.last.last
        nil # Equal frequency, no mode.
      else
        top_2.first.first # Most frequent is mode.
      end
    end

    def sample_variance
      sum = self.inject(0) {|accumulator, value| accumulator + (value - mean) ** 2 }
      sum / (length.to_f - 1)
    end

    def standard_deviation
      return if length < 2
      Math.sqrt(sample_variance)
    end
  end
end