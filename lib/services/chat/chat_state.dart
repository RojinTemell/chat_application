import 'package:equatable/equatable.dart';

final class ChatState extends Equatable {
  const ChatState({required this.isLoading});
  final bool isLoading;
  @override
  
  List<Object?> get props => [isLoading];

  ChatState copyWith({bool? isLoading}) {
    return ChatState(isLoading: isLoading ?? this.isLoading);
  }
}
