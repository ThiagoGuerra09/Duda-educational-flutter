# Arquitetura — Duda Educador

Este documento descreve as decisões arquiteturais do projeto e o raciocínio por trás delas.

## Visão geral

O Duda Educador foi construído como um produto de longa duração: escalável, testável e com identidade visual centralizada. A arquitetura segue **Clean Architecture** com separação rigorosa entre Presentation, Domain e Data.

```
┌─────────────────────────────────────────────┐
│              Presentation                    │
│  Pages → Widgets Duda* → Cubit → State      │
└────────────────────┬────────────────────────┘
                     │ UseCase
┌────────────────────▼────────────────────────┐
│                 Domain                       │
│  Entities, Repository (abstract), UseCases  │
└────────────────────┬────────────────────────┘
                     │ RepositoryImpl
┌────────────────────▼────────────────────────┐
│                  Data                        │
│  Models, DataSource, RepositoryImpl, JSON   │
└─────────────────────────────────────────────┘
```

## Por que Clean Architecture?

- **Testabilidade**: Use cases e cubits podem ser testados isoladamente com mocks.
- **Independência de frameworks**: Domain não conhece Flutter, Dio ou JSON.
- **Substituição de fontes de dados**: Trocar mock por API real exige mudanças apenas na camada Data.
- **Escalabilidade de time**: Features isoladas em módulos (`features/home`, `features/chat`, etc.).

## Por que Cubit?

Cubit foi escolhido por ser a variante mais enxuta do pacote `flutter_bloc`:

- Estados explícitos e previsíveis (`Loading`, `Loaded`, `Failure`)
- Menos boilerplate que BLoC com eventos
- Amplamente adotado em empresas que citam Bloc no stack
- Integração natural com `BlocBuilder` para rebuilds localizados

**Regra**: estados de negócio nunca usam `setState`. Apenas animações locais de UI podem usá-lo.

## Por que Repository Pattern?

Todo acesso a dados passa por um contrato abstrato no Domain:

```dart
abstract class HomeRepository {
  Future<HomeData> getHomeData();
}
```

A implementação na camada Data pode ler JSON, SQLite ou API REST sem afetar UseCases ou Cubits.

## Por que GetIt + Injectable?

- Registro automático via anotações (`@injectable`, `@LazySingleton`)
- Cubits registrados como factory; repositórios como singleton
- Módulos (`@module`) para Dio e GoRouter
- Alternativa considerada: **Riverpod** — descartada neste POC para manter foco em Bloc/Cubit + DI clássica, comum em entrevistas técnicas

## Por que GoRouter?

- Navegação declarativa com deep linking
- `StatefulShellRoute` para bottom navigation com 6 abas preservando estado
- Redirect centralizado para autenticação (splash → login → home)

## Por que Design System (Duda*)?

Inspirado em práticas de empresas como Nubank e iFood:

- Telas **não** usam `Container`, `Text`, `Scaffold` diretamente
- Componentes encapsulam tokens (`AppColors`, `AppTypography`, `AppSpacing`)
- Mudança de identidade visual = alterar apenas `shared/design_system/`

Isso reduz inconsistências e acelera onboarding de novos desenvolvedores.

## Mock HTTP com Dio

O `MockInterceptor`:

1. Aplica delay de 800ms (simula rede)
2. Mapeia rotas `/api/*` para arquivos em `assets/mock/`
3. Suporta `?fail=true` para testar estados de erro

Para produção: remover o interceptor e configurar `baseUrl` real.

## Cache em memória

`MemoryCache` com TTL de 5 minutos evita re-fetch desnecessário durante a sessão. Cache invalidado no logout ou pull-to-refresh.

## Trade-offs conscientes

| Decisão | Prós | Contras |
|---------|------|---------|
| Mock via assets | Zero backend, demo rápida | Não testa serialização real de API |
| 6 abas no bottom nav | Cobre todas as features | UI apertada em telas pequenas (scroll horizontal) |
| GetIt manual + codegen | Explícito, debugável | Requer `build_runner` após mudanças DI |
| Sem Freezed nos models | Menos codegen, build mais rápido | Mais código manual em `fromJson` |

## Testes

- **Unitários**: Cubits (bloc_test) e UseCases (mocktail)
- **Próximo passo**: Widget tests com Design System e golden tests visuais

## Conclusão

A arquitetura prioriza **manutenibilidade** e **demonstração de maturidade técnica** — separação de responsabilidades, componentização visual e fluxo de dados unidirecional do Cubit até o JSON mockado.
