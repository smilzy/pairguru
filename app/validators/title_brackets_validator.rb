class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:title, 'Wrong title (unmatched brackets)') unless check_brackets(record.title)
  end

  private

  def check_brackets(title)
    brackets = { '(' => ')', '[' => ']', '{' => '}' }
    result   = []

    title.chars do |char|
      result << char if brackets.key?(char)
      return false if brackets.key(char) && brackets.key(char) != result.pop
    end
    result.empty? && ! title.scan(/(\(\)|\[\]|\{\})/).any?
  end
end
