
const catchAsync = require("../util/catchAsync");
exports.test = catchAsync(async (req, res, next) => {
    return res.status(400).json({
      status: "test status",
      message: "test test",
    });
  });