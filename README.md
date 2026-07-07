# Duda Educador

Prova de conceito em Flutter inspirada no aplicativo **Duda Educador** da Cruzeiro do Sul Educacional. O projeto demonstra Clean Architecture, Design System proprietário, Cubit, injeção de dependência e navegação declarativa — com dados mockados simulando chamadas HTTP.

## Stack

| Tecnologia | Uso |
|------------|-----|
| Flutter 3.44.5 | Framework UI |
| Cubit (flutter_bloc) | Gerenciamento de estado |
| GetIt + Injectable | Injeção de dependência |
| GoRouter | Navegação |
| Dio | Cliente HTTP (mock via interceptor) |
| Equatable | Value equality |
| Google Fonts (Inter) | Tipografia |

## Pré-requisitos

- [FVM](https://fvm.app/) instalado
- Xcode 26+ (para iOS)
- Simulador iOS (ex.: iPhone 17 Pro)

## Setup

```bash
cd Duda-educational-flutter

# Instalar Flutter 3.44.5 (se ainda não tiver)
fvm install 3.44.5
fvm use 3.44.5

# Dependências e codegen
make setup
# ou manualmente:
# fvm flutter pub get
# fvm dart run build_runner build
```

## Executar

```bash
# Listar dispositivos
fvm flutter devices

# Rodar no simulador
make run
# ou:
fvm flutter run -d "iPhone 17 Pro"
```

## Login mock

Qualquer e-mail e senha válidos (não vazios) autenticam o usuário.

## Estrutura do projeto

```
lib/
├── core/           # Rede, router, cache, erros, serviços
├── features/       # Módulos por funcionalidade (Clean Architecture)
│   ├── splash/
│   ├── auth/
│   ├── home/
│   ├── classes/
│   ├── schedule/
│   ├── notifications/
│   ├── chat/
│   └── profile/
└── shared/
    ├── design_system/   # Componentes Duda* + tokens visuais
    └── widgets/         # Cards compostos de domínio UI
```

### Fluxo de camadas

```
Presentation (Cubit + Pages)
        ↓
Domain (UseCase → Repository abstract)
        ↓
Data (RepositoryImpl → DataSource → JSON mock)
```

## Funcionalidades

- **Splash** — Logo, loading e checagem de sessão
- **Login** — Autenticação mock
- **Home** — Boas-vindas, carousel de disciplinas, pendências, acesso rápido
- **Turmas** — Lista com cards e detalhe (alunos, atividades, notas, presença)
- **Agenda** — Calendário e eventos
- **Notificações** — Lista com filtros por categoria
- **Chat** — Conversas e mensagens estilo WhatsApp (mock + envio local)
- **Perfil** — Dados do professor e logout

## Design System

Todas as telas utilizam componentes `Duda*` (`DudaScaffold`, `DudaText`, `DudaButton`, `DudaCard`, etc.) em vez de widgets Material diretos. Alterações visuais devem ocorrer apenas em `lib/shared/design_system/`.

## Scripts

| Comando | Descrição |
|---------|-----------|
| `make get` | `flutter pub get` |
| `make gen` | Codegen (Injectable) |
| `make run` | Executa no iPhone 17 Pro |
| `make analyze` | Análise estática |
| `make test` | Testes unitários |

## Próximos passos

- Integração com API real (substituir `MockInterceptor`)
- Testes de integração e golden tests
- Push notifications (Firebase)
- Persistência local (Hive/Isar) para cache offline
- Dark mode no Design System

## Documentação adicional

Consulte [ARCHITECTURE.md](ARCHITECTURE.md) para decisões técnicas detalhadas.
