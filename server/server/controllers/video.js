
const videos = [
    {
        id: '1',
        name: "人生副本1",
        videoLen: "360",
        videoUrl: "userId/videos/butterfly.mp4",
        thumbNail: "userId/images/sunset.jpg",
        description: "You only live once ",
        series: ['1', '2', '3']
    },
    {
        id: '2',
        name: "人生副本2",
        videoLen: "480",
        videoUrl: "userId/videos/butterfly.mp4",
        thumbNail: "userId/images/fuji.jpg",
        description: "Too long too much too long1234567",
        series: ['1', '2', '3']
    },
    {
        id: '3',
        name: "人生副本3",
        videoLen: "480",
        videoUrl: "userId/videos/butterfly.mp4",
        thumbNail: "userId/images/hill.jpg",
        description: "just nothing",
        series: ['1', '2', '3']
    },
    {
        id: '4',
        name: "其它",
        videoLen: "480",
        videoUrl: "userId/videos/butterfly.mp4",
        thumbNail: "userId/images/hill.jpg",
        description: "just nothing"
    }];

module.exports = {
    videoDetail(req, res) {
        console.log('videoDetail:' + req.query.Id)
        var id = req.query.Id;
        try {
            const videoDetail = videos[id - 1];
            return res.status(200).json({
                code: 200,
                msg: "Success",
                data: videoDetail
            });

        } catch (error) {
            return res.status(500).json({ error: error.message })
        }
    },

    videoSeriesList(req, res) {
        console.log('videoSeriesList:' + req.query.Id)
        try {
            var filteredVideos = videos.filter(video => video.series?.some(seriesItem => seriesItem == req.query.Id))
            return res.status(200).json({
                code: 200,
                msg: "Success",
                data: filteredVideos
            });
        } catch (error) {
            return res.status(500).json({ error: error.message })
        }
    },

    getVideoList(req, res) {
        console.log('getVideoList')
        try {
            return res.status(200).json({
                code: 200,
                msg: "Success",
                data: videos
            });

        } catch (error) {
            return res.status(500).json({ error: error.message })
        }
    }
}