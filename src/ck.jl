module ck

using HTTP
using JSON
using FileIO
using Images
using ImageInTerminal
# using Sixel

export catto


function get_image(url)
    img = mktemp() do fn, f
        download(url, fn)
        load(fn)
    end
    img_resized = imresize(img, 500, 500)
end

function catto()
    res = HTTP.get("https://cutekitty.pythonanywhere.com/catto/search/?type=jpg&type=png")
    imgdict = JSON.parse(String(res.body))[1]
    return get_image(imgdict["img"])
end

end # module
