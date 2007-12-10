module Treetop
  module Compiler    
    class CharacterClass < AtomicExpression
      def compile(address, builder, parent_expression = nil)
        super
        
        builder.if__ "input.index(/#{text_value}/, index) == index" do
          assign_result "(#{node_class_name}).new(input, index...(index + 1))"
          extend_result_with_inline_module
          builder << "@index += 1"
        end
        builder.else_ do
          "terminal_parse_failure('#{elements[1].text_value.gsub(/'$/, "\\'")}')"
          assign_result 'nil'
        end
      end
    end
  end
end