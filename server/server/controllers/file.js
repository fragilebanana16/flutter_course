module.exports = {
  receiveFile(req, res) {
    try {
        return res.json({ img: req.file.filename });
      } catch (e) {
        return res.json({ error: e });
      }
  }
};