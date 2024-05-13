
const catchAsync = require("../util/catchAsync");
exports.test = catchAsync(async (req, res, next) => {
  console.log('test')
    return res.status(400).json({
      status: "test status",
      message: "test test",
    });
  });