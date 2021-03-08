import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String photo;

  const User(
      {@required this.id,
      @required this.email,
      @required this.username,
      @required this.photo})
      : assert(email != null),
        assert(id != null);

  static const empty = User(id: '', email: '', username: null, photo: null);

  @override
  // TODO: implement props
  List<Object> get props => [id, email, username, photo];
}
