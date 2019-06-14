module GOVUKDesignSystemFormBuilder
  module Elements
    class Label < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, text: nil, value: nil, size: 'regular', weight: 'regular')
        super(builder, object_name, attribute_name)

        @text         = label_text(text)
        @value        = value # used by attribute_descriptor
        @size_class   = label_size_class(size)
        @weight_class = label_weight_class(weight)
      end

      def html
        return nil unless @text.present?

        @builder.label(
          @attribute_name,
          @text,
          value: @value,
          class: %w(govuk-label).push(@size_class, @weight_class).compact
        )
      end

    private

      def label_text(option_text)
        [option_text, @value, @attribute_name.capitalize].compact.first
      end

      def label_size_class(size)
        case size
        when 'large'   then "govuk-!-font-size-48"
        when 'medium'  then "govuk-!-font-size-36"
        when 'small'   then "govuk-!-font-size-27"
        when 'regular' then nil
        else
          fail 'size must be either large, medium, small or regular'
        end
      end

      def label_weight_class(weight)
        case weight
        when 'bold'    then "govuk-!-font-weight-bold"
        when 'regular' then nil
        else
          fail 'weight must be bold or regular'
        end
      end
    end
  end
end