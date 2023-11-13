def update_quality(items)
  items.each do |item|
    quality_change = item.sell_in > 0 ? 1 : 2

    case item.name
    when 'Aged Brie'
      item.quality += quality_change
    when 'Backstage passes to a TAFKAL80ETC concert'
      item.quality += 1
      item.quality += 1 if item.sell_in <= 10
      item.quality += 1 if item.sell_in <= 5
      item.quality = 0 if item.sell_in <= 0
    when 'Sulfuras, Hand of Ragnaros'
      next
    else
      quality_change *= 2 if item.name.match?(/\AConjured\s/)
      item.quality -= quality_change
    end

    item.quality = item.quality.clamp(0, 50)
    item.sell_in -= 1
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

