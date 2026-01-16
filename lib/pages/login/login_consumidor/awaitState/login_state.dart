import '../../loginSteps/login_steps.dart';

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
          "Enviando código de confirmação para o seu email...",
          "Quase tudo pronto...",
          "Por favor, verifique o seu emal!"
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
