module ck

using HTTP
using JSON
using FileIO
using Images
using ImageInTerminal
using Sixel

export catto


function get_image(url)
    img = mktemp() do fn, f
        download(url, fn)
        load(fn)
    end
    img_resized = imresize(img, ratio = 1 / 2)
end

function catto()
    res = HTTP.get("https://api.thecatapi.com/v1/images/search")
    imgdict = JSON.parse(String(res.body))[1]
    return get_image(imgdict["url"])
end

end # module
