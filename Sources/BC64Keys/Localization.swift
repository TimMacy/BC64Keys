import Foundation

// MARK: - Supported Languages
enum AppLanguage: String, CaseIterable, Codable {
    case system = "system"
    case english = "en"
    case hungarian = "hu"
    case german = "de"
    case french = "fr"
    case spanish = "es"
    case italian = "it"
    case japanese = "ja"
    case chinese = "zh"
    case dutch = "nl"
    case portuguese = "pt"
    case swedish = "sv"
    case danish = "da"
    case finnish = "fi"
    case polish = "pl"
    case czech = "cs"
    case slovak = "sk"
    case romanian = "ro"
    case greek = "el"
    case korean = "ko"
    case arabic = "ar"
    case hebrew = "he"
    case turkish = "tr"
    
    var displayName: String {
        switch self {
        case .system: return L10n.current.languageSystem
        case .english: return "English"
        case .hungarian: return "Magyar"
        case .german: return "Deutsch"
        case .french: return "Français"
        case .spanish: return "Español"
        case .italian: return "Italiano"
        case .japanese: return "日本語"
        case .chinese: return "中文"
        case .dutch: return "Nederlands"
        case .portuguese: return "Português"
        case .swedish: return "Svenska"
        case .danish: return "Dansk"
        case .finnish: return "Suomi"
        case .polish: return "Polski"
        case .czech: return "Čeština"
        case .slovak: return "Slovenčina"
        case .romanian: return "Română"
        case .greek: return "Ελληνικά"
        case .korean: return "한국어"
        case .arabic: return "العربية"
        case .hebrew: return "עברית"
        case .turkish: return "Türkçe"
        }
    }
    
    static var current: AppLanguage {
        let saved = UserDefaults.standard.string(forKey: "bc64keys.language") ?? "system"
        return AppLanguage(rawValue: saved) ?? .system
    }
    
    static func save(_ language: AppLanguage) {
        UserDefaults.standard.set(language.rawValue, forKey: "bc64keys.language")
        L10n.reload()
    }
    
    var effectiveLanguage: String {
        switch self {
        case .system:
            // Compatible with macOS 11+
            let systemLang: String
            if #available(macOS 13, *) {
                systemLang = Locale.current.language.languageCode?.identifier ?? "en"
            } else {
                systemLang = Locale.current.languageCode ?? "en"
            }
            // Support all major macOS markets
            let supported = ["hu", "en", "de", "fr", "es", "it", "ja", "zh", "nl", "pt", "sv", "da", "fi", "pl", "cs", "sk", "ro", "el", "ko", "ar", "he", "tr"]
            return supported.contains(systemLang) ? systemLang : "en"
        case .english: return "en"
        case .hungarian: return "hu"
        case .german: return "de"
        case .french: return "fr"
        case .spanish: return "es"
        case .italian: return "it"
        case .japanese: return "ja"
        case .chinese: return "zh"
        case .dutch: return "nl"
        case .portuguese: return "pt"
        case .swedish: return "sv"
        case .danish: return "da"
        case .finnish: return "fi"
        case .polish: return "pl"
        case .czech: return "cs"
        case .slovak: return "sk"
        case .romanian: return "ro"
        case .greek: return "el"
        case .korean: return "ko"
        case .arabic: return "ar"
        case .hebrew: return "he"
        case .turkish: return "tr"
        }
    }
}

// MARK: - Localization Manager
class L10n: ObservableObject {
    static var shared = L10n()
    static var current: L10n { shared }
    
    @Published private(set) var lang: String
    
    init() {
        self.lang = AppLanguage.current.effectiveLanguage
    }
    
    func setLanguage(_ language: AppLanguage) {
        AppLanguage.save(language)
    }
    
    static func reload() {
        shared.lang = AppLanguage.current.effectiveLanguage
        shared.objectWillChange.send()
    }
    
    // Helper function for multi-language strings
    // Falls back to English if translation is missing for a language
    private func tr(_ translations: [String: String]) -> String {
        // Try current language first
        if let translation = translations[lang], !translation.isEmpty {
            return translation
        }
        // Fallback to English
        return translations["en"] ?? ""
    }
    
    // MARK: - App General
    var appName: String { "BC64Keys" }
    
    // MARK: - Tabs
    var tabMonitor: String {
        tr(["en": "Monitor", "hu": "Figyelő", "de": "Monitor", "fr": "Moniteur", 
            "es": "Monitor", "it": "Monitor", "ja": "モニター", "zh": "监视器",
            "nl": "Monitor", "pt": "Monitor", "sv": "Övervakare", "pl": "Monitor",
            "ko": "모니터", "ar": "مراقب", "tr": "İzleyici"])
    }
    var tabMapping: String {
        tr(["en": "Mapping", "hu": "Módosítás", "de": "Zuordnung", "fr": "Mappage",
            "es": "Mapeo", "it": "Mappatura", "ja": "マッピング", "zh": "映射",
            "nl": "Mapping", "pt": "Mapeamento", "sv": "Mappning", "pl": "Mapowanie",
            "ko": "매핑", "ar": "تعيين", "tr": "Eşleme"])
    }
    var tabSettings: String {
        tr(["en": "Settings", "hu": "Beállítások", "de": "Einstellungen", "fr": "Paramètres",
            "es": "Ajustes", "it": "Impostazioni", "ja": "設定", "zh": "设置",
            "nl": "Instellingen", "pt": "Configurações", "sv": "Inställningar", "pl": "Ustawienia",
            "ko": "설정", "ar": "الإعدادات", "tr": "Ayarlar"])
    }
    
    // MARK: - Status Bar
    var statusAccessibility: String { "Accessibility" }
    var statusNoPermission: String {
        tr(["en": "No permission", "hu": "Nincs engedély", "de": "Keine Berechtigung", "fr": "Pas de permission",
            "es": "Sin permiso", "it": "Nessun permesso", "ja": "権限なし", "zh": "无权限"])
    }
    var statusEnabled: String {
        tr(["en": "Enabled", "hu": "Engedélyezve", "de": "Aktiviert", "fr": "Activé",
            "es": "Habilitado", "it": "Abilitato", "ja": "有効", "zh": "已启用"])
    }
    var statusRemapper: String { "Remapper" }
    var statusRunning: String {
        tr(["en": "Running", "hu": "Fut", "de": "Läuft", "fr": "En cours",
            "es": "Ejecutando", "it": "In esecuzione", "ja": "実行中", "zh": "运行中"])
    }
    var statusStopped: String {
        tr(["en": "Stopped", "hu": "Leállítva", "de": "Gestoppt", "fr": "Arrêté",
            "es": "Detenido", "it": "Fermato", "ja": "停止", "zh": "已停止"])
    }
    var statusUpdated: String {
        tr(["en": "Updated", "hu": "Frissítve", "de": "Aktualisiert", "fr": "Mis à jour",
            "es": "Actualizado", "it": "Aggiornato", "ja": "更新済み", "zh": "已更新"])
    }
    var statusAccessRequired: String {
        tr(["en": "Permission required", "hu": "Hozzáférés megadása szükséges", "de": "Berechtigung erforderlich", "fr": "Permission requise",
            "es": "Permiso requerido", "it": "Permesso richiesto", "ja": "権限が必要", "zh": "需要权限"])
    }
    var statusAppPath: String {
        tr(["en": "App path", "hu": "App útvonal", "de": "App-Pfad", "fr": "Chemin de l'app",
            "es": "Ruta de la app", "it": "Percorso app", "ja": "アプリパス", "zh": "应用路径"])
    }
    var openSettings: String {
        tr(["en": "Open Settings", "hu": "Beállítások Megnyitása", "de": "Einstellungen öffnen", "fr": "Ouvrir les paramètres",
            "es": "Abrir ajustes", "it": "Apri impostazioni", "ja": "設定を開く", "zh": "打开设置"])
    }
    
    // MARK: - Monitor View
    var monitorTitle: String {
        tr(["en": "Key Monitor", "hu": "Billentyű Figyelő", "de": "Tastaturmonitor", "fr": "Moniteur de clavier",
            "es": "Monitor de teclado", "it": "Monitor tastiera", "ja": "キーモニター", "zh": "键盘监视器"])
    }
    var startMonitoring: String {
        tr(["en": "Start Monitoring", "hu": "Figyelés Indítása", "de": "Überwachung starten", "fr": "Démarrer la surveillance",
            "es": "Iniciar monitoreo", "it": "Avvia monitoraggio", "ja": "監視開始", "zh": "开始监视"])
    }
    var stopMonitoring: String {
        tr(["en": "Stop Monitoring", "hu": "Figyelés Leállítása", "de": "Überwachung stoppen", "fr": "Arrêter la surveillance",
            "es": "Detener monitoreo", "it": "Ferma monitoraggio", "ja": "監視停止", "zh": "停止监视"])
    }
    var clear: String {
        tr(["en": "Clear", "hu": "Törlés", "de": "Löschen", "fr": "Effacer",
            "es": "Limpiar", "it": "Cancella", "ja": "クリア", "zh": "清除"])
    }
    var monitorHintStart: String {
        tr(["en": "Click 'Start Monitoring' button!", "hu": "Kattints a 'Figyelés Indítása' gombra!", "de": "Klicken Sie auf 'Überwachung starten'!", "fr": "Cliquez sur 'Démarrer la surveillance'!",
            "es": "¡Haz clic en 'Iniciar monitoreo'!", "it": "Clicca su 'Avvia monitoraggio'!", "ja": "「監視開始」ボタンをクリック！", "zh": "点击'开始监视'按钮！"])
    }
    var monitorHintActive: String {
        tr(["en": "Active monitoring - Press any key", "hu": "Aktív figyelés - Nyomj le bármilyen billentyűt", "de": "Aktive Überwachung - Drücken Sie eine Taste", "fr": "Surveillance active - Appuyez sur une touche",
            "es": "Monitoreo activo - Presione cualquier tecla", "it": "Monitoraggio attivo - Premi un tasto", "ja": "監視中 - 任意のキーを押してください", "zh": "监视中 - 按任意键"])
    }
    var noEvents: String {
        tr(["en": "No events yet", "hu": "Még nincsenek események", "de": "Noch keine Ereignisse", "fr": "Aucun événement",
            "es": "Sin eventos aún", "it": "Nessun evento", "ja": "イベントなし", "zh": "暂无事件"])
    }
    var noEventsHint: String {
        tr(["en": "Start monitoring and press keys", "hu": "Indítsd el a figyelést és nyomj le billentyűket", "de": "Überwachung starten und Tasten drücken", "fr": "Démarrez la surveillance et appuyez sur des touches",
            "es": "Inicie el monitoreo y presione teclas", "it": "Avvia il monitoraggio e premi i tasti", "ja": "監視を開始してキーを押してください", "zh": "开始监视并按键"])
    }
    
    // MARK: - Mapping View
    var mappingTitle: String {
        tr(["en": "Key Mappings", "hu": "Billentyű Módosítások", "de": "Tastenzuordnungen", "fr": "Mappages de touches",
            "es": "Mapeos de teclas", "it": "Mappature dei tasti", "ja": "キーマッピング", "zh": "键映射"])
    }
    var newRule: String {
        tr(["en": "New Rule", "hu": "Új Szabály", "de": "Neue Regel", "fr": "Nouvelle règle",
            "es": "Nueva regla", "it": "Nuova regola", "ja": "新規ルール", "zh": "新规则"])
    }
    var noRules: String {
        tr(["en": "No rules yet", "hu": "Még nincsenek szabályok", "de": "Noch keine Regeln", "fr": "Aucune règle",
            "es": "Sin reglas aún", "it": "Nessuna regola", "ja": "ルールなし", "zh": "暂无规则"])
    }
    var noRulesHint: String {
        tr(["en": "Click 'New Rule' button", "hu": "Kattints az 'Új Szabály' gombra", "de": "Klicken Sie auf 'Neue Regel'", "fr": "Cliquez sur 'Nouvelle règle'",
            "es": "Haz clic en 'Nueva regla'", "it": "Clicca su 'Nuova regola'", "ja": "「新規ルール」をクリック", "zh": "点击'新规则'"])
    }
    var keySwap: String {
        tr(["en": "Key swap", "hu": "Billentyű csere", "de": "Tastentausch", "fr": "Échange de touches",
            "es": "Intercambio de teclas", "it": "Scambio tasti", "ja": "キー交換", "zh": "键交换"])
    }
    var controlAction: String {
        tr(["en": "Control action", "hu": "Vezérlő művelet", "de": "Steuerungsaktion", "fr": "Action de contrôle",
            "es": "Acción de control", "it": "Azione di controllo", "ja": "制御アクション", "zh": "控制操作"])
    }
    
    // MARK: - Add Mapping Sheet
    var newKeyRule: String {
        tr(["en": "New Key Mapping Rule", "hu": "Új Billentyű Szabály", "de": "Neue Tastenzuordnungsregel", "fr": "Nouvelle règle de mappage",
            "es": "Nueva regla de mapeo", "it": "Nuova regola di mappatura", "ja": "新しいキーマッピングルール", "zh": "新建键映射规则"])
    }
    var editKeyRule: String {
        tr(["en": "Edit Key Mapping Rule", "hu": "Billentyű Szabály Szerkesztése", "de": "Tastenzuordnungsregel bearbeiten", "fr": "Modifier la règle de mappage",
            "es": "Editar regla de mapeo", "it": "Modifica regola di mappatura", "ja": "キーマッピングルールを編集", "zh": "编辑键映射规则",
            "nl": "Sleutelmappingsregel bewerken", "pt": "Editar regra de mapeamento", "sv": "Redigera tangentmappningsregel", "da": "Rediger tastemappingsregel",
            "fi": "Muokkaa näppäinvastaavuussääntöä", "pl": "Edytuj regułę mapowania klawiszy", "cs": "Upravit pravidlo mapování kláves", "sk": "Upraviť pravidlo mapovania klávesov",
            "ro": "Editare regulă de mapare taste", "el": "Επεξεργασία κανόνα αντιστοίχισης πλήκτρων", "ko": "키 매핑 규칙 편집", "ar": "تحرير قاعدة تعيين المفاتيح",
            "he": "ערוך כלל מיפוי מקשים", "tr": "Tuş eşleme kuralını düzenle"])
    }
    var ruleType: String {
        tr(["en": "Rule type", "hu": "Szabály típusa", "de": "Regeltyp", "fr": "Type de règle",
            "es": "Tipo de regla", "it": "Tipo di regola", "ja": "ルールタイプ", "zh": "规则类型"])
    }
    var source: String {
        tr(["en": "SOURCE", "hu": "FORRÁS", "de": "QUELLE", "fr": "SOURCE",
            "es": "ORIGEN", "it": "SORGENTE", "ja": "ソース", "zh": "源"])
    }
    var target: String {
        tr(["en": "TARGET", "hu": "CÉL", "de": "ZIEL", "fr": "CIBLE",
            "es": "DESTINO", "it": "DESTINAZIONE", "ja": "ターゲット", "zh": "目标"])
    }
    var pressKey: String {
        tr(["en": "Press a key...", "hu": "Nyomj egy billentyűt...", "de": "Taste drücken...", "fr": "Appuyez sur une touche...",
            "es": "Presione una tecla...", "it": "Premi un tasto...", "ja": "キーを押してください...", "zh": "按任意键..."])
    }
    var clickHere: String {
        tr(["en": "Click here", "hu": "Kattints ide", "de": "Hier klicken", "fr": "Cliquez ici",
            "es": "Haz clic aquí", "it": "Clicca qui", "ja": "ここをクリック", "zh": "点击此处"])
    }
    var selectAction: String {
        tr(["en": "Select action", "hu": "Válassz műveletet", "de": "Aktion wählen", "fr": "Sélectionner une action",
            "es": "Seleccionar acción", "it": "Seleziona azione", "ja": "アクションを選択", "zh": "选择操作"])
    }
    var select: String {
        tr(["en": "Select...", "hu": "Válassz...", "de": "Wählen...", "fr": "Sélectionner...",
            "es": "Seleccionar...", "it": "Seleziona...", "ja": "選択...", "zh": "选择..."])
    }
    var cancel: String {
        tr(["en": "Cancel", "hu": "Mégse", "de": "Abbrechen", "fr": "Annuler",
            "es": "Cancelar", "it": "Annulla", "ja": "キャンセル", "zh": "取消",
            "nl": "Annuleren", "pt": "Cancelar", "sv": "Avbryt", "pl": "Anuluj",
            "ko": "취소", "ar": "إلغاء", "tr": "İptal"])
    }
    var save: String {
        tr(["en": "Save", "hu": "Mentés", "de": "Speichern", "fr": "Enregistrer",
            "es": "Guardar", "it": "Salva", "ja": "保存", "zh": "保存",
            "nl": "Opslaan", "pt": "Salvar", "sv": "Spara", "pl": "Zapisz",
            "ko": "저장", "ar": "حفظ", "tr": "Kaydet"])
    }
    
    // MARK: - Settings View
    var settingsTitle: String {
        tr(["en": "Settings", "hu": "Beállítások", "de": "Einstellungen", "fr": "Paramètres",
            "es": "Ajustes", "it": "Impostazioni", "ja": "設定", "zh": "设置"])
    }
    var launchAtLogin: String {
        tr(["en": "Launch at login", "hu": "Indítás bejelentkezéskor", "de": "Bei Anmeldung starten", "fr": "Lancer à la connexion",
            "es": "Iniciar al iniciar sesión", "it": "Avvia all'accesso", "ja": "ログイン時に起動", "zh": "登录时启动"])
    }
    var launchAtLoginDescription: String {
        tr(["en": "Start automatically when you log in", "hu": "Automatikus indítás rendszerindításkor", "de": "Automatisch starten bei Anmeldung", "fr": "Démarrer automatiquement à la connexion",
            "es": "Iniciar automáticamente al iniciar sesión", "it": "Avvia automaticamente all'accesso", "ja": "ログイン時に自動起動", "zh": "登录时自动启动"])
    }
    var launchAtLoginHint: String {
        tr(["en": "The app will start automatically when you turn on your computer.", "hu": "Az alkalmazás automatikusan elindul a számítógép bekapcsolásakor.", "de": "Die App startet automatisch beim Einschalten des Computers.", "fr": "L'application démarre automatiquement au démarrage de l'ordinateur.",
            "es": "La aplicación se iniciará automáticamente al encender la computadora.", "it": "L'app si avvierà automaticamente all'accensione del computer.", "ja": "コンピュータの起動時にアプリが自動的に起動します。", "zh": "打开计算机时应用将自动启动。"])
    }
    var language: String {
        tr(["en": "Language", "hu": "Nyelv", "de": "Sprache", "fr": "Langue",
            "es": "Idioma", "it": "Lingua", "ja": "言語", "zh": "语言",
            "nl": "Taal", "pt": "Idioma", "sv": "Språk", "pl": "Język",
            "ko": "언어", "ar": "اللغة", "tr": "Dil"])
    }
    var languageHint: String {
        tr(["en": "Language changes immediately.", "hu": "A nyelv azonnal változik.", "de": "Sprache ändert sich sofort.", "fr": "La langue change immédiatement.",
            "es": "El idioma cambia inmediatamente.", "it": "La lingua cambia immediatamente.", "ja": "言語はすぐに変更されます。", "zh": "语言立即更改。"])
    }
    var debugLogging: String {
        tr(["en": "Debug logging", "hu": "Hibakeresési napló", "de": "Debug-Protokollierung", "fr": "Journalisation de débogage",
            "es": "Registro de depuración", "it": "Registrazione debug", "ja": "デバッグログ", "zh": "调试日志"])
    }
    var debugLoggingDescription: String {
        tr(["en": "Enable detailed logging", "hu": "Részletes naplózás engedélyezése", "de": "Detaillierte Protokollierung aktivieren", "fr": "Activer la journalisation détaillée",
            "es": "Habilitar registro detallado", "it": "Abilita registrazione dettagliata", "ja": "詳細ログを有効化", "zh": "启用详细日志"])
    }
    var debugLoggingHint: String {
        tr(["en": "⚠️ For debugging only! Log file: ~/Library/Logs/BC64Keys/", "hu": "⚠️ Csak hibakereséshez! Naplófájl helye: ~/Library/Logs/BC64Keys/", "de": "⚠️ Nur zum Debuggen! Protokolldatei: ~/Library/Logs/BC64Keys/", "fr": "⚠️ Pour le débogage uniquement! Fichier journal: ~/Library/Logs/BC64Keys/",
            "es": "⚠️ ¡Solo para depuración! Archivo de registro: ~/Library/Logs/BC64Keys/", "it": "⚠️ Solo per debug! File di log: ~/Library/Logs/BC64Keys/", "ja": "⚠️ デバッグ専用！ログファイル: ~/Library/Logs/BC64Keys/", "zh": "⚠️ 仅用于调试！日志文件：~/Library/Logs/BC64Keys/"])
    }
    var support: String {
        tr(["en": "Support", "hu": "Támogatás", "de": "Unterstützung", "fr": "Soutien",
            "es": "Soporte", "it": "Supporto", "ja": "サポート", "zh": "支持"])
    }
    var supportDescription: String {
        tr(["en": "If you like this app, buy me a coffee! ☕", "hu": "Ha tetszik az app, támogass egy kávéval! ☕", "de": "Wenn Ihnen diese App gefällt, spendieren Sie mir einen Kaffee! ☕", "fr": "Si vous aimez cette app, offrez-moi un café! ☕",
            "es": "¡Si te gusta esta app, cómprame un café! ☕", "it": "Se ti piace questa app, offrimi un caffè! ☕", "ja": "このアプリが気に入ったら、コーヒーをおごってください！ ☕", "zh": "如果您喜欢这个应用，请给我买杯咖啡！ ☕"])
    }
    var supportButton: String {
        tr(["en": "Buy Me a Coffee", "hu": "Támogatom", "de": "Spendiere einen Kaffee", "fr": "Offrir un café",
            "es": "Cómprame un café", "it": "Offrimi un caffè", "ja": "コーヒーをおごる", "zh": "给我买杯咖啡"])
    }
    var about: String {
        tr(["en": "About", "hu": "Névjegy", "de": "Über", "fr": "À propos",
            "es": "Acerca de", "it": "Informazioni", "ja": "について", "zh": "关于"])
    }
    var aboutDescription: String {
        tr(["en": "Keyboard remapping application for Windows to Mac switchers.", "hu": "Billentyűzet módosító alkalmazás Windows-ról Mac-re váltók számára.", "de": "Tastaturumlegungs-App für Umsteiger von Windows zu Mac.", "fr": "Application de remappage de clavier pour les utilisateurs passant de Windows à Mac.",
            "es": "Aplicación de remapeo de teclado para usuarios que cambian de Windows a Mac.", "it": "Applicazione di rimappatura della tastiera per chi passa da Windows a Mac.", "ja": "WindowsからMacに移行する人のためのキーボードリマッピングアプリ。", "zh": "为从Windows切换到Mac的用户提供的键盘重映射应用程序。"])
    }
    
    // MARK: - Language Selection
    var languageSystem: String {
        tr(["en": "System", "hu": "Rendszer", "de": "System", "fr": "Système",
            "es": "Sistema", "it": "Sistema", "ja": "システム", "zh": "系统",
            "nl": "Systeem", "pt": "Sistema", "sv": "System", "pl": "System",
            "ko": "시스템", "ar": "النظام", "tr": "Sistem"])
    }
    
    // MARK: - Per-App Filtering
    var appFilter: String {
        tr(["en": "Application Filter", "hu": "Alkalmazásszűrő", "de": "Anwendungsfilter", "fr": "Filtre d'application",
            "es": "Filtro de aplicación", "it": "Filtro applicazioni", "ja": "アプリケーションフィルタ", "zh": "应用程序过滤器",
            "nl": "Applicatiefilter", "pt": "Filtro de aplicativo", "sv": "Programfilter", "da": "Programfilter",
            "fi": "Sovellussuodatin", "pl": "Filtr aplikacji", "cs": "Filtr aplikací", "sk": "Filter aplikácií",
            "ro": "Filtru aplicații", "el": "Φίλτρο εφαρμογών", "ko": "응용 프로그램 필터", "ar": "مرشح التطبيقات", "he": "סינון יישומים", "tr": "Uygulama Filtresi"])
    }
    var filterAllApps: String {
        tr(["en": "All applications", "hu": "Minden alkalmazás", "de": "Alle Anwendungen", "fr": "Toutes les applications",
            "es": "Todas las aplicaciones", "it": "Tutte le applicazioni", "ja": "すべてのアプリケーション", "zh": "所有应用程序",
            "nl": "Alle applicaties", "pt": "Todos os aplicativos", "sv": "Alla program", "da": "Alle programmer",
            "fi": "Kaikki sovellukset", "pl": "Wszystkie aplikacje", "cs": "Všechny aplikace", "sk": "Všetky aplikácie",
            "ro": "Toate aplicațiile", "el": "Όλες οι εφαρμογές", "ko": "모든 응용 프로그램", "ar": "جميع التطبيقات", "he": "כל היישומים", "tr": "Tüm uygulamalar"])
    }
    var filterExclude: String {
        tr(["en": "All except selected", "hu": "Minden, kivéve a kiválasztottak", "de": "Alle außer ausgewählte", "fr": "Tous sauf sélectionnés",
            "es": "Todos excepto seleccionados", "it": "Tutti tranne selezionati", "ja": "選択されたもの以外", "zh": "除选定项外的所有项",
            "nl": "Alle behalve geselecteerd", "pt": "Todos exceto selecionados", "sv": "Alla utom valda", "da": "Alle undtagen valgte",
            "fi": "Kaikki paitsi valitut", "pl": "Wszystkie z wyjątkiem wybranych", "cs": "Všechny kromě vybraných", "sk": "Všetky okrem vybraných",
            "ro": "Toate cu excepția celor selectate", "el": "Όλα εκτός από τα επιλεγμένα", "ko": "선택한 항목을 제외한 모든 항목", "ar": "الكل ما عدا المحدد", "he": "הכל מלבד הנבחרים", "tr": "Seçilenler hariç tümü"])
    }
    var filterInclude: String {
        tr(["en": "Only selected applications", "hu": "Csak a kiválasztott alkalmazások", "de": "Nur ausgewählte Anwendungen", "fr": "Seulement les applications sélectionnées",
            "es": "Solo aplicaciones seleccionadas", "it": "Solo applicazioni selezionate", "ja": "選択されたアプリケーションのみ", "zh": "仅选定的应用程序",
            "nl": "Alleen geselecteerde applicaties", "pt": "Somente aplicativos selecionados", "sv": "Endast valda program", "da": "Kun valgte programmer",
            "fi": "Vain valitut sovellukset", "pl": "Tylko wybrane aplikacje", "cs": "Pouze vybrané aplikace", "sk": "Iba vybraté aplikácie",
            "ro": "Doar aplicațiile selectate", "el": "Μόνο επιλεγμένες εφαρμογές", "ko": "선택한 응용 프로그램만", "ar": "التطبيقات المحددة فقط", "he": "רק יישומים נבחרים", "tr": "Yalnızca seçilen uygulamalar"])
    }
    var runningApps: String {
        tr(["en": "Running Applications", "hu": "Futó alkalmazások", "de": "Laufende Anwendungen", "fr": "Applications en cours d'exécution",
            "es": "Aplicaciones en ejecución", "it": "Applicazioni in esecuzione", "ja": "実行中のアプリケーション", "zh": "正在运行的应用程序",
            "nl": "Actieve applicaties", "pt": "Aplicativos em execução", "sv": "Körande program", "da": "Kørende programmer",
            "fi": "Käynnissä olevat sovellukset", "pl": "Uruchomione aplikacje", "cs": "Spuštěné aplikace", "sk": "Spustené aplikácie",
            "ro": "Aplicații în execuție", "el": "Εφαρμογές σε εκτέλεση", "ko": "실행 중인 응용 프로그램", "ar": "التطبيقات قيد التشغيل", "he": "יישומים פועלים", "tr": "Çalışan uygulamalar"])
    }
    var appNotRunningHint: String {
        tr(["en": "Open the application to add it to the list", "hu": "Nyisd meg az alkalmazást, hogy hozzáadhasd a listához", "de": "Öffnen Sie die Anwendung, um sie zur Liste hinzuzufügen", "fr": "Ouvrez l'application pour l'ajouter à la liste",
            "es": "Abra la aplicación para agregarla a la lista", "it": "Apri l'applicazione per aggiungerla all'elenco", "ja": "リストに追加するにはアプリケーションを開いてください", "zh": "打开应用程序以将其添加到列表",
            "nl": "Open de applicatie om deze aan de lijst toe te voegen", "pt": "Abra o aplicativo para adicioná-lo à lista", "sv": "Öppna programmet för att lägga till det i listan", "da": "Åbn programmet for at tilføje det til listen",
            "fi": "Avaa sovellus lisätäksesi sen luetteloon", "pl": "Otwórz aplikację, aby dodać ją do listy", "cs": "Otevřete aplikaci a přidejte ji do seznamu", "sk": "Otvorte aplikáciu, aby ste ju pridali do zoznamu",
            "ro": "Deschideți aplicația pentru a o adăuga la listă", "el": "Ανοίξτε την εφαρμογή για να την προσθέσετε στη λίστα", "ko": "목록에 추가하려면 응용 프로그램을 여세요", "ar": "افتح التطبيق لإضافته إلى القائمة", "he": "פתח את היישום כדי להוסיף אותו לרשימה", "tr": "Listeye eklemek için uygulamayı açın"])
    }
    
    // MARK: - Navigation Actions
    var actionDiscard: String {
        tr(["en": "🚫 Discard (block key)", "hu": "🚫 Elvetés (billentyű letiltása)", 
            "de": "🚫 Verwerfen (Taste blockieren)", "fr": "🚫 Ignorer (bloquer touche)",
            "es": "🚫 Descartar (bloquear tecla)", "it": "🚫 Scarta (blocca tasto)",
            "ja": "🚫 破棄（キーをブロック）", "zh": "🚫 丢弃（阻止按键）",
            "nl": "🚫 Negeren (toets blokkeren)", "pt": "🚫 Descartar (bloquear tecla)",
            "sv": "🚫 Ignorera (blockera tangent)", "pl": "🚫 Odrzuć (zablokuj klawisz)",
            "ko": "🚫 버리기 (키 차단)", "tr": "🚫 At (tuşu engelle)"])
    }
    var actionLineStart: String {
        tr(["en": "Line start", "hu": "Sor elejére",
            "de": "Zeilenanfang", "fr": "Début de ligne",
            "es": "Inicio de línea", "it": "Inizio riga",
            "ja": "行頭", "zh": "行首",
            "nl": "Regelbegin", "pt": "Início da linha",
            "sv": "Radens början", "pl": "Początek linii",
            "ko": "줄 시작", "tr": "Satır başı"])
    }
    var actionLineEnd: String {
        tr(["en": "Line end", "hu": "Sor végére",
            "de": "Zeilenende", "fr": "Fin de ligne",
            "es": "Fin de línea", "it": "Fine riga",
            "ja": "行末", "zh": "行尾",
            "nl": "Regeleinde", "pt": "Fim da linha",
            "sv": "Radens slut", "pl": "Koniec linii",
            "ko": "줄 끝", "tr": "Satır sonu"])
    }
    var actionSelectLineStart: String {
        tr(["en": "Select to line start", "hu": "Kijelölés a sor elejéig",
            "de": "Bis Zeilenanfang auswählen", "fr": "Sélectionner jusqu'au début",
            "es": "Seleccionar hasta inicio", "it": "Seleziona fino a inizio",
            "ja": "行頭まで選択", "zh": "选择到行首",
            "nl": "Selecteer tot regelbegin", "pt": "Selecionar até início",
            "sv": "Markera till radens början", "pl": "Zaznacz do początku",
            "ko": "줄 시작까지 선택", "tr": "Satır başına kadar seç"])
    }
    var actionSelectLineEnd: String {
        tr(["en": "Select to line end", "hu": "Kijelölés a sor végéig",
            "de": "Bis Zeilenende auswählen", "fr": "Sélectionner jusqu'à la fin",
            "es": "Seleccionar hasta fin", "it": "Seleziona fino a fine",
            "ja": "行末まで選択", "zh": "选择到行尾",
            "nl": "Selecteer tot regeleinde", "pt": "Selecionar até fim",
            "sv": "Markera till radens slut", "pl": "Zaznacz do końca",
            "ko": "줄 끝까지 선택", "tr": "Satır sonuna kadar seç"])
    }
    var actionDocStart: String {
        tr(["en": "Document start", "hu": "Dokumentum elejére",
            "de": "Dokumentanfang", "fr": "Début du document",
            "es": "Inicio del documento", "it": "Inizio documento",
            "ja": "文書の先頭", "zh": "文档开头",
            "nl": "Documentbegin", "pt": "Início do documento",
            "sv": "Dokumentets början", "pl": "Początek dokumentu",
            "ko": "문서 시작", "tr": "Belge başı"])
    }
    var actionDocEnd: String {
        tr(["en": "Document end", "hu": "Dokumentum végére",
            "de": "Dokumentende", "fr": "Fin du document",
            "es": "Fin del documento", "it": "Fine documento",
            "ja": "文書の末尾", "zh": "文档结尾",
            "nl": "Documenteinde", "pt": "Fim do documento",
            "sv": "Dokumentets slut", "pl": "Koniec dokumentu",
            "ko": "문서 끝", "tr": "Belge sonu"])
    }
    var actionSelectDocStart: String {
        tr(["en": "Select to doc start", "hu": "Kijelölés a dokumentum elejéig",
            "de": "Bis Dokumentanfang auswählen", "fr": "Sélectionner jusqu'au début du doc",
            "es": "Seleccionar hasta inicio doc", "it": "Seleziona fino a inizio doc",
            "ja": "文書の先頭まで選択", "zh": "选择到文档开头",
            "nl": "Selecteer tot documentbegin", "pt": "Selecionar até início doc",
            "sv": "Markera till dokumentets början", "pl": "Zaznacz do początku dok.",
            "ko": "문서 시작까지 선택", "tr": "Belge başına kadar seç"])
    }
    var actionSelectDocEnd: String {
        tr(["en": "Select to doc end", "hu": "Kijelölés a dokumentum végéig",
            "de": "Bis Dokumentende auswählen", "fr": "Sélectionner jusqu'à la fin du doc",
            "es": "Seleccionar hasta fin doc", "it": "Seleziona fino a fine doc",
            "ja": "文書の末尾まで選択", "zh": "选择到文档结尾",
            "nl": "Selecteer tot documenteinde", "pt": "Selecionar até fim doc",
            "sv": "Markera till dokumentets slut", "pl": "Zaznacz do końca dok.",
            "ko": "문서 끝까지 선택", "tr": "Belge sonuna kadar seç"])
    }
    var actionWordStart: String {
        tr(["en": "Word start", "hu": "Szó elejére",
            "de": "Wortanfang", "fr": "Début du mot",
            "es": "Inicio de palabra", "it": "Inizio parola",
            "ja": "単語の先頭", "zh": "词首",
            "nl": "Woordbegin", "pt": "Início da palavra",
            "sv": "Ordets början", "pl": "Początek słowa",
            "ko": "단어 시작", "tr": "Kelime başı"])
    }
    var actionWordEnd: String {
        tr(["en": "Word end", "hu": "Szó végére",
            "de": "Wortende", "fr": "Fin du mot",
            "es": "Fin de palabra", "it": "Fine parola",
            "ja": "単語の末尾", "zh": "词尾",
            "nl": "Woordeinde", "pt": "Fim da palavra",
            "sv": "Ordets slut", "pl": "Koniec słowa",
            "ko": "단어 끝", "tr": "Kelime sonu"])
    }
    var actionSelectWordStart: String {
        tr(["en": "Select to word start", "hu": "Kijelölés a szó elejéig",
            "de": "Bis Wortanfang auswählen", "fr": "Sélectionner jusqu'au début du mot",
            "es": "Seleccionar hasta inicio palabra", "it": "Seleziona fino a inizio parola",
            "ja": "単語の先頭まで選択", "zh": "选择到词首",
            "nl": "Selecteer tot woordbegin", "pt": "Selecionar até início palavra",
            "sv": "Markera till ordets början", "pl": "Zaznacz do początku słowa",
            "ko": "단어 시작까지 선택", "tr": "Kelime başına kadar seç"])
    }
    var actionSelectWordEnd: String {
        tr(["en": "Select to word end", "hu": "Kijelölés a szó végéig",
            "de": "Bis Wortende auswählen", "fr": "Sélectionner jusqu'à la fin du mot",
            "es": "Seleccionar hasta fin palabra", "it": "Seleziona fino a fine parola",
            "ja": "単語の末尾まで選択", "zh": "选择到词尾",
            "nl": "Selecteer tot woordeinde", "pt": "Selecionar até fim palavra",
            "sv": "Markera till ordets slut", "pl": "Zaznacz do końca słowa",
            "ko": "단어 끝까지 선택", "tr": "Kelime sonuna kadar seç"])
    }
    var actionDeleteWordLeft: String {
        tr(["en": "Delete word left", "hu": "Szó törlése balra",
            "de": "Wort links löschen", "fr": "Supprimer mot à gauche",
            "es": "Eliminar palabra izquierda", "it": "Elimina parola sinistra",
            "ja": "左の単語を削除", "zh": "删除左边单词",
            "nl": "Woord links verwijderen", "pt": "Apagar palavra esquerda",
            "sv": "Radera ord vänster", "pl": "Usuń słowo w lewo",
            "ko": "왼쪽 단어 삭제", "tr": "Sol kelimeyi sil"])
    }
    var actionDeleteWordRight: String {
        tr(["en": "Delete word right", "hu": "Szó törlése jobbra",
            "de": "Wort rechts löschen", "fr": "Supprimer mot à droite",
            "es": "Eliminar palabra derecha", "it": "Elimina parola destra",
            "ja": "右の単語を削除", "zh": "删除右边单词",
            "nl": "Woord rechts verwijderen", "pt": "Apagar palavra direita",
            "sv": "Radera ord höger", "pl": "Usuń słowo w prawo",
            "ko": "오른쪽 단어 삭제", "tr": "Sağ kelimeyi sil"])
    }
    var actionDeleteLineStart: String {
        tr(["en": "Delete to line start", "hu": "Törlés a sor elejéig",
            "de": "Bis Zeilenanfang löschen", "fr": "Supprimer jusqu'au début de ligne",
            "es": "Eliminar hasta inicio línea", "it": "Elimina fino a inizio riga",
            "ja": "行頭まで削除", "zh": "删除到行首",
            "nl": "Verwijder tot regelbegin", "pt": "Apagar até início da linha",
            "sv": "Radera till radens början", "pl": "Usuń do początku linii",
            "ko": "줄 시작까지 삭제", "tr": "Satır başına kadar sil"])
    }
    var actionPageUp: String {
        tr(["en": "Page Up", "hu": "Lap fel",
            "de": "Seite hoch", "fr": "Page haut",
            "es": "Página arriba", "it": "Pagina su",
            "ja": "ページアップ", "zh": "向上翻页",
            "nl": "Pagina omhoog", "pt": "Página acima",
            "sv": "Sida upp", "pl": "Strona w górę",
            "ko": "페이지 위로", "tr": "Sayfa yukarı"])
    }
    var actionPageDown: String {
        tr(["en": "Page Down", "hu": "Lap le",
            "de": "Seite runter", "fr": "Page bas",
            "es": "Página abajo", "it": "Pagina giù",
            "ja": "ページダウン", "zh": "向下翻页",
            "nl": "Pagina omlaag", "pt": "Página abaixo",
            "sv": "Sida ner", "pl": "Strona w dół",
            "ko": "페이지 아래로", "tr": "Sayfa aşağı"])
    }
    var actionUndo: String {
        tr(["en": "Undo", "hu": "Visszavonás",
            "de": "Rückgängig", "fr": "Annuler",
            "es": "Deshacer", "it": "Annulla",
            "ja": "元に戻す", "zh": "撤销",
            "nl": "Ongedaan maken", "pt": "Desfazer",
            "sv": "Ångra", "pl": "Cofnij",
            "ko": "실행 취소", "tr": "Geri al"])
    }
    var actionRedo: String {
        tr(["en": "Redo", "hu": "Újra",
            "de": "Wiederholen", "fr": "Rétablir",
            "es": "Rehacer", "it": "Ripeti",
            "ja": "やり直す", "zh": "重做",
            "nl": "Opnieuw", "pt": "Refazer",
            "sv": "Gör om", "pl": "Ponów",
            "ko": "다시 실행", "tr": "Yinele"])
    }
    var actionCut: String {
        tr(["en": "Cut", "hu": "Kivágás",
            "de": "Ausschneiden", "fr": "Couper",
            "es": "Cortar", "it": "Taglia",
            "ja": "切り取り", "zh": "剪切",
            "nl": "Knippen", "pt": "Cortar",
            "sv": "Klipp ut", "pl": "Wytnij",
            "ko": "잘라내기", "tr": "Kes"])
    }
    var actionCopy: String {
        tr(["en": "Copy", "hu": "Másolás",
            "de": "Kopieren", "fr": "Copier",
            "es": "Copiar", "it": "Copia",
            "ja": "コピー", "zh": "复制",
            "nl": "Kopiëren", "pt": "Copiar",
            "sv": "Kopiera", "pl": "Kopiuj",
            "ko": "복사", "tr": "Kopyala"])
    }
    var actionPaste: String {
        tr(["en": "Paste", "hu": "Beillesztés",
            "de": "Einfügen", "fr": "Coller",
            "es": "Pegar", "it": "Incolla",
            "ja": "貼り付け", "zh": "粘贴",
            "nl": "Plakken", "pt": "Colar",
            "sv": "Klistra in", "pl": "Wklej",
            "ko": "붙여넣기", "tr": "Yapıştır"])
    }
    var actionSelectAll: String {
        tr(["en": "Select All", "hu": "Összes kijelölése",
            "de": "Alles auswählen", "fr": "Tout sélectionner",
            "es": "Seleccionar todo", "it": "Seleziona tutto",
            "ja": "すべて選択", "zh": "全选",
            "nl": "Alles selecteren", "pt": "Selecionar tudo",
            "sv": "Markera allt", "pl": "Zaznacz wszystko",
            "ko": "모두 선택", "tr": "Tümünü seç"])
    }
    var actionFind: String {
        tr(["en": "Find", "hu": "Keresés",
            "de": "Suchen", "fr": "Rechercher",
            "es": "Buscar", "it": "Trova",
            "ja": "検索", "zh": "查找",
            "nl": "Zoeken", "pt": "Procurar",
            "sv": "Sök", "pl": "Znajdź",
            "ko": "찾기", "tr": "Bul"])
    }
    var actionFindNext: String {
        tr(["en": "Find Next", "hu": "Következő keresése",
            "de": "Weitersuchen", "fr": "Rechercher suivant",
            "es": "Buscar siguiente", "it": "Trova successivo",
            "ja": "次を検索", "zh": "查找下一个",
            "nl": "Volgende zoeken", "pt": "Procurar próximo",
            "sv": "Sök nästa", "pl": "Znajdź następny",
            "ko": "다음 찾기", "tr": "Sonrakini bul"])
    }
    var actionSave: String {
        tr(["en": "Save", "hu": "Mentés",
            "de": "Speichern", "fr": "Enregistrer",
            "es": "Guardar", "it": "Salva",
            "ja": "保存", "zh": "保存",
            "nl": "Opslaan", "pt": "Salvar",
            "sv": "Spara", "pl": "Zapisz",
            "ko": "저장", "tr": "Kaydet"])
    }
    var actionSaveAs: String {
        tr(["en": "Save As", "hu": "Mentés másként",
            "de": "Speichern unter", "fr": "Enregistrer sous",
            "es": "Guardar como", "it": "Salva come",
            "ja": "名前を付けて保存", "zh": "另存为",
            "nl": "Opslaan als", "pt": "Salvar como",
            "sv": "Spara som", "pl": "Zapisz jako",
            "ko": "다른 이름으로 저장", "tr": "Farklı kaydet"])
    }
    var actionCloseWindow: String {
        tr(["en": "Close Window/Tab", "hu": "Ablak/Fül bezárása",
            "de": "Fenster/Tab schließen", "fr": "Fermer fenêtre/onglet",
            "es": "Cerrar ventana/pestaña", "it": "Chiudi finestra/scheda",
            "ja": "ウィンドウ/タブを閉じる", "zh": "关闭窗口/标签",
            "nl": "Venster/tab sluiten", "pt": "Fechar janela/aba",
            "sv": "Stäng fönster/flik", "pl": "Zamknij okno/kartę",
            "ko": "창/탭 닫기", "tr": "Pencere/sekme kapat"])
    }
    var actionQuit: String {
        tr(["en": "Quit", "hu": "Kilépés",
            "de": "Beenden", "fr": "Quitter",
            "es": "Salir", "it": "Esci",
            "ja": "終了", "zh": "退出",
            "nl": "Afsluiten", "pt": "Sair",
            "sv": "Avsluta", "pl": "Zakończ",
            "ko": "종료", "tr": "Çık"])
    }
    var actionNewWindow: String {
        tr(["en": "New Window/Document", "hu": "Új ablak/dokumentum",
            "de": "Neues Fenster/Dokument", "fr": "Nouvelle fenêtre/document",
            "es": "Nueva ventana/documento", "it": "Nuova finestra/documento",
            "ja": "新規ウィンドウ/文書", "zh": "新窗口/文档",
            "nl": "Nieuw venster/document", "pt": "Nova janela/documento",
            "sv": "Nytt fönster/dokument", "pl": "Nowe okno/dokument",
            "ko": "새 창/문서", "tr": "Yeni pencere/belge"])
    }
    var actionNewTab: String {
        tr(["en": "New Tab", "hu": "Új fül",
            "de": "Neuer Tab", "fr": "Nouvel onglet",
            "es": "Nueva pestaña", "it": "Nuova scheda",
            "ja": "新規タブ", "zh": "新标签",
            "nl": "Nieuw tabblad", "pt": "Nova aba",
            "sv": "Ny flik", "pl": "Nowa karta",
            "ko": "새 탭", "tr": "Yeni sekme"])
    }
    var actionSwitchApp: String {
        tr(["en": "Switch App", "hu": "Alkalmazás váltása",
            "de": "App wechseln", "fr": "Changer d'application",
            "es": "Cambiar de aplicación", "it": "Cambia app",
            "ja": "アプリを切り替え", "zh": "切换应用",
            "nl": "Wisselen van app", "pt": "Alternar app",
            "sv": "Växla app", "pl": "Przełącz aplikację",
            "ko": "앱 전환", "tr": "Uygulama değiştir"])
    }
    var actionSwitchWindow: String {
        tr(["en": "Switch Window", "hu": "Ablak váltása",
            "de": "Fenster wechseln", "fr": "Changer de fenêtre",
            "es": "Cambiar de ventana", "it": "Cambia finestra",
            "ja": "ウィンドウを切り替え", "zh": "切换窗口",
            "nl": "Wisselen van venster", "pt": "Alternar janela",
            "sv": "Växla fönster", "pl": "Przełącz okno",
            "ko": "창 전환", "tr": "Pencere değiştir"])
    }
    var actionSwitchAppReverse: String {
        tr(["en": "Switch App (Reverse)", "hu": "Alkalmazás váltása (visszafelé)",
            "de": "App wechseln (rückwärts)", "fr": "Changer d'application (arrière)",
            "es": "Cambiar de aplicación (atrás)", "it": "Cambia app (indietro)",
            "ja": "アプリを切り替え(逆方向)", "zh": "切换应用(反向)",
            "nl": "Wisselen van app (achteruit)", "pt": "Alternar app (reverso)",
            "sv": "Växla app (bakåt)", "pl": "Przełącz aplikację (odwrotnie)",
            "ko": "앱 전환(역방향)", "tr": "Uygulama değiştir (ters)"])
    }
    var actionSwitchWindowReverse: String {
        tr(["en": "Switch Window (Reverse)", "hu": "Ablak váltása (visszafelé)",
            "de": "Fenster wechseln (rückwärts)", "fr": "Changer de fenêtre (arrière)",
            "es": "Cambiar de ventana (atrás)", "it": "Cambia finestra (indietro)",
            "ja": "ウィンドウを切り替え(逆方向)", "zh": "切换窗口(反向)",
            "nl": "Wisselen van venster (achteruit)", "pt": "Alternar janela (reverso)",
            "sv": "Växla fönster (bakåt)", "pl": "Przełącz okno (odwrotnie)",
            "ko": "창 전환(역방향)", "tr": "Pencere değiştir (ters)"])
    }

    // MARK: - Visual Keyboard
    var visualKeyboard: String {
        tr(["en": "Visual Keyboard", "hu": "Vizuális billentyűzet",
            "de": "Visuelle Tastatur", "fr": "Clavier visuel",
            "es": "Teclado visual", "it": "Tastiera visiva",
            "ja": "ビジュアルキーボード", "zh": "可视化键盘",
            "nl": "Visueel toetsenbord", "pt": "Teclado visual",
            "sv": "Visuellt tangentbord", "pl": "Wizualna klawiatura",
            "ko": "시각적 키보드", "tr": "Görsel klavye"])
    }
    var showKeyboard: String {
        tr(["en": "Show Keyboard", "hu": "Billentyűzet mutatása",
            "de": "Tastatur anzeigen", "fr": "Afficher le clavier",
            "es": "Mostrar teclado", "it": "Mostra tastiera",
            "ja": "キーボードを表示", "zh": "显示键盘",
            "nl": "Toon toetsenbord", "pt": "Mostrar teclado",
            "sv": "Visa tangentbord", "pl": "Pokaż klawiaturę",
            "ko": "키보드 표시", "tr": "Klavyeyi göster"])
    }
    var hideKeyboard: String {
        tr(["en": "Hide Keyboard", "hu": "Billentyűzet elrejtése",
            "de": "Tastatur ausblenden", "fr": "Masquer le clavier",
            "es": "Ocultar teclado", "it": "Nascondi tastiera",
            "ja": "キーボードを非表示", "zh": "隐藏键盘",
            "nl": "Verberg toetsenbord", "pt": "Ocultar teclado",
            "sv": "Dölj tangentbord", "pl": "Ukryj klawiaturę",
            "ko": "키보드 숨기기", "tr": "Klavyeyi gizle"])
    }
    var clickToSelect: String {
        tr(["en": "Click a key to select it", "hu": "Kattints egy billentyűre a kiválasztásához",
            "de": "Klicken Sie auf eine Taste", "fr": "Cliquez sur une touche",
            "es": "Haz clic en una tecla", "it": "Clicca su un tasto",
            "ja": "キーをクリックして選択", "zh": "点击按键选择",
            "nl": "Klik op een toets", "pt": "Clique em uma tecla",
            "sv": "Klicka på en tangent", "pl": "Kliknij klawisz",
            "ko": "키를 클릭하여 선택", "tr": "Bir tuşa tıklayın"])
    }
}

