const Room = require('../models').Room;

module.exports = {
  create(req, res) {
    return Room
      .create({
        title: req.body.title,
        connections: JSON.stringify(req.body.connections)
      })
      .then((todo) => res.status(201).send(todo))
      .catch((error) => res.status(400).send(error));
  },

  retrieve(req, res) {
    return Room.findOne({ where: { title: req.body.title } })
      .then((room) => {
        if (!room) {
          return res.status(404).send({
            message: 'Room Not Found',
          });
        }
        return res.status(200).send(room);
      })
      .catch((error) => res.status(400).send(error));
  },
};