class TransactionBundleState {
  final int priority;
  final bool jito;

  TransactionBundleState({required this.priority, required this.jito});

  factory TransactionBundleState.init(int improved, bool jito) =>
      TransactionBundleState(priority: improved, jito: jito);
}
