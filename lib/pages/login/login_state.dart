import 'login_steps.dart';

class LoginState {
  AcessoStep step;

  bool isLoading;
  int messageIndex;

  final List<String> mensagens;

  LoginState({
    this.step = AcessoStep.initState,
    this.isLoading = false,
    this.messageIndex = 0,
    List<String>? mensagens,
  }) : mensagens = mensagens ??
        const [
          "Estamos a configurar o seu acesso...",
          "A preparar o ambiente...",
          "Quase tudo pronto...",
        ];

  LoginState copyWith({
    AcessoStep? step,
    bool? isLoading,
    int? messageIndex,
  }) {
    return LoginState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      messageIndex: messageIndex ?? this.messageIndex,
      mensagens: mensagens,
    );
  }
}
