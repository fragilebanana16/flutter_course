part of home;

class _Header extends StatelessWidget {
  const _Header({required this.user, Key? key}) : super(key: key);

  final _User user;
  final double _maxWidthForUsername = 200.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: IconButton(
                    constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                    iconSize: 25,
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      // https://stackoverflow.com/questions/55618717/error-thrown-on-navigator-pop-until-debuglocked-is-not-true
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutesNames.APPLICATION);
                      });
                    },
                    icon: Transform.scale(
                      scale: -1, // 镜像显示
                      child: const Icon(Icons.exit_to_app),
                    ),
                    tooltip: "Exit",
                  )),
            ],
          ),
        ),
        SizedBox(width: kDefaultSpacing),
        SearchButton(onPressed: () {}),
      ],
    );
  }

  Widget _title() {
    return Text(
      "Good Morning",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget _subtitle() {
    return Container(
      constraints: BoxConstraints(maxWidth: _maxWidthForUsername),
      child: Text(
        user.name.capitalizeFirst!,
        style: TextStyle(fontSize: 20),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _emoji() {
    return SizedBox(
      width: 20,
      child: Image.asset(
        ImageRaster.wavingHandEmoji,
        height: 20,
        width: 20,
      ),
    );
  }
}
