require('mini_magick')

MiniMagick.configure do |config|
  config.cli = :graphicsmagick
  config.timeout = 5
end

def offset(x)
  if x <= 0
    "#{x}"
  else
    "+#{x}"
  end
end

def stack(image1, image2)
  x = rand(-100..100)
  y = rand(-100..100)
  image1.composite(image2) do |c|
    c.compose "Over"
    c.geometry "#{offset(x)}#{offset(y)}"
  end  
end

red  = MiniMagick::Image.new("images/red-circle.png")
blue  = MiniMagick::Image.new("images/blue-square.png")
green  = MiniMagick::Image.new("images/green-pentagon.png")
yellow  = MiniMagick::Image.new("images/yellow-star.png")
layers = [red, blue, green, yellow]

result = layers.reduce do |result, layer|
  stack(result, layer)
end

result.write "output.png"
