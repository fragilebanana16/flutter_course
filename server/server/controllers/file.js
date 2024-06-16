const sizeOf = require("image-size")
function addImageDimensions(images) {
  return images.map((imageObj) => {
    try {
      const dimensions = sizeOf(imageObj.path);
      return {...imageObj, width: dimensions.width, height: dimensions.height };
    } catch (error) {
      console.error(`Error getting dimensions for ${imageObj.path}:`, error);
      return imageObj;
    }
  });
}

module.exports = {
  receiveFile(req, res)  {
    try {
      console.log(req.files)
      const processedImages = addImageDimensions(req.files);
        return res.json({ img: processedImages});
      } catch (e) {
      console.log(e)
        return res.json({ error: e });
      }
  },


};