## Tarix, teglar va relizlar

> **O'tgan dars bilan bog'liqlik:** loyihangiz toza va saranjom. Endi uni «rasmiy» qilamiz: loyiha tarixini o'qishni, versiyalarni to'g'ri nomerlashni va GitHubda relizlarni nashr qilishni o'rganamiz — xuddi haqiqiy dasturiy ta'minotda bo'lgani kabi.

---

## Dars maqsadi

Repozitoriy tarixi bilan ishlashni o'zlashtirish: commitlarda yo'nalishni topish, versiyalarni solishtirish, semantik versiyalashni tushunish va teglar hamda GitHub relizlari orqali loyihaning barqaror versiyalarini nashr etish.

## Dars oxirida nimani o'rganasiz

- `git log` orqali tarixni o'qish va `git show` orqali commitlarni ko'rish.
- `git diff` orqali commit va versiyalarni solishtirish.
- Versiyalarni to'g'ri nomerlash — semantik versiyalash `MAJOR.MINOR.PATCH`.
- `git tag` teglarini yaratish va ularni GitHubga nashr qilish.
- GitHubda o'zgarishlar tavsifi bilan Release yaratish.

---

## Dars vaqti

| Blok | Mazmun |
| --- | --- |
| 1. Tarixni o'qish | `git log`, `git show`, `git blame` |
| 2. Versiyalarni solishtirish | Commitlar orasida `git diff` |
| 3. Semantik versiyalash | MAJOR.MINOR.PATCH qoidalari |
| 4. Teglar | Lightweight va annotated teglar |
| 5. Relizlar va CHANGELOG | Versiyani odamlar uchun nashr qilish |
| 6. Mini-vazifa | Yo'lni belgilash |
| 7. Xulosalar va amaliy vazifa | Mustahkamlash |

---

## 1-blok. Tarixni o'qish

Commit logi — loyihaning kundaligi. O'qish uchun eng muhim buyruqlar:

### `git log`

```bash
git log            # to'liq tarix: kim, qachon, nima
git log --oneline  # har commitga bitta qator — kundalik ko'rinish
git log --graph    # branchlar daraxt ko'rinishida
git log --stat     # har commitda qaysi fayllar o'zgargan
git log -p         # har commitning to'liq diffi (uzoq!)
```

Filtrlari ham qo'l keladi:

```bash
git log --oneline --author="Javlon"      # faqat bu muallifning commitlari
git log --oneline --since="2 weeks ago"  # faqat oxirgilari
git log --oneline -n 5                   # faqat oxirgi beshta
git log --oneline -- README.md           # faqat README.mdga teggan commitlar
```

**Pro-maslahat:** `--oneline`dan keyin `-g` qo'shib, *reflog*ni ko'rasiz — repozitoriyda bo'lib o'tgan hamma narsa, jumladan reset va rebase logi.

### `git show`

Bitta commitni batafsil ko'rish:

```bash
git show HEAD          # eng yangi commit
git show 8f3d2c1       # xesh bo'yicha aniq commit
git show HEAD~1        # HEADdan oldingi commit
```

`HEAD~N` — N commit orqaga (ota-onalar zanjiri). `HEAD~1` — bu `HEAD^`.

### `git blame`

Qaysi qatorni kim yozgan:

```bash
git blame README.md
```

Har bir qator oxirgi teggan commit, muallif va sanani ko'rsatadi. Bug topib, «bu qatorni kim va nima uchun o'zgartirgan»ni tushunish kerak bo'lganda bebahо.

---

## 2-blok. Versiyalarni solishtirish

`git diff` «ikki nuqta o'rtasida nima o'zgardi?» degan savolga javob beradi.

```bash
git diff                    # ishchi katalog vs indeks (stage qilinmagan)
git diff --staged           # indeks vs oxirgi commit (stage qilingan)
git diff HEAD               # barcha commit qilinmagan: staged va boshqalar
git diff 8f3d2c1..4b5a1c2   # ikki commit o'rtasida
git diff v1.0.0 v1.1.0      # ikki teg o'rtasida
```

Real stsenariy: Pull Request bo'yicha tuzatishlar keldi va reviewer branchining maindan farqini ko'rish kerak:

```bash
git diff main..feature/contact
```

`-` bilan qatorlar o'chirilgan, `+` bilan qo'shilgan. Bu jamoada kod muhokamasining tili — hamma `git diff`da gapiradi.

---

## 3-blok. Semantik versiyalash

Versiyalarni hamma tushunadigan tarzda qanday nomerlash mumkin? Bu — **SemVer**, xalqaro standart:

```text
MAJOR.MINOR.PATCH        masalan 1.4.2
```

| Qism | Qachon oshadi |
| --- | --- |
| **MAJOR** | Buzuvchi o'zgarishlar — eski kod ishlamay qolishi mumkin |
| **MINOR** | Yangi funksiyalar, orqaga moslik saqlanadi |
| **PATCH** | Faqat xatolarni tuzatish |

Misollar:

- `1.0.0` — birinchi ochiq reliz.
- `1.0.1` — xatoni tuzatdik, yangi hech narsa yo'q.
- `1.1.0` — funksiya qo'shdik.
- `2.0.0` — biron narsani buzдик; `1.x` ishlatganlarga tekshirish kerak.

**Qoida:** mavjud foydalanuvchilarda «buzilishi mumkin» bo'lsa — major oshadi; bo'lmasa — minor yoki patch.

---

## 4-blok. Teglar

**Teg** — aniq commitga berilgan nom: harakatlanmaydigan tarix xatcho'pi.

### Yaratish

```bash
git tag v1.0.0              # lightweight teg
git tag -a v1.0.1 -m "Release 1.0.1"   # annotated teg
```

| Tur | Tarkib | Qachon |
| --- | --- | --- |
| **Lightweight** | shunchaki nom-ko'rsatkich | tezkor belgi, qoralama |
| **Annotated** | nom + muallif + sana + xabar | haqiqiy relizlar — tavsiya etiladi |

### Ko'rish va navigatsiya

```bash
git tag          # teglar ro'yxati
git tag -l "v1.*" # filtr
git show v1.0.0  # teg'langan commitni ko'rish
git diff v1.0.0 v1.1.0   # relizlar orasida nima o'zgardi
```

### GitHubga nashr qilish

Teglar o'zi masofaviyga bormaydi:

```bash
git push origin v1.0.0        # bitta teg
git push origin --tags        # barcha teglar
```

Tegni o'chirish (lokalda va masofaviyda):

```bash
git tag -d v1.0.0
git push origin --delete v1.0.0
```

**Muhim:** teg hech qachon harakatlanmasligi kerak — «yangi» versiya kerak bo'lsa, yangi teg yarating. Teglarni qayta yozish ularni yuklab olganlarni adashtiradi.

---

## 5-blok. Relizlar va CHANGELOG

Teg — texnik, **Release** — odamlar uchun. GitHubda: repozitoriy oching → **Releases** → **Draft a new release** → mavjud tegni tanlang (yoki yangisini yarating) → tavsif yozing → nashr qiling.

Reliz tavsifida odatda:

- nima yangi (fichыs);
- nima o'zgardi (yaxshilanishlar);
- nima tuzatildi (fixlar);
- buzuvchi o'zgarishlar (agar major oshgan bo'lsa);
- hissa qo'shuvchilarga rahmat.

GitHub teg'langan kod bilan arxivni (`zip`/`tar.gz`) avtomatik yig'adi — `.git` papkasiz distributiv.

### CHANGELOG

Ko'plab yetuk loyihalar `CHANGELOG.md` — relizlarning xronologik ro'yxatini yuritadi. «Keep a Changelog» konventsiyasi tavsiyasi:

```text
## [Unreleased]
- Yaqin kelajakdagi o'zgarishlar

## [1.1.0] - 2026-05-12
### Added
- yangi funksiya
### Fixed
- xato tavsifi
```

CHANGELOG + teglar + relizlar = manbalarni o'qimasdan ham hamma tushunadigan va ishlatadigan loyiha.

---

## Mini-vazifa

Kichik o'quv loyihasida:

1. Butun tarixni daraxt ko'rinishida ko'ring: `git log --oneline --graph`.
2. Eng birinchi commitni `git show` orqali ko'ring.
3. Hozirgi holat uchun `v1.0.0` annotated tegini yarating.
4. Uni simulyator skriptida masofaviyga «nashr qiling».

**Yechim:**

```bash
git log --oneline --graph
git show $(git rev-list --max-parents=0 HEAD)   # eng birinchi commit
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0
```

---

## Dars xulosalari

Bugun siz quyidagilarni o'rgandingiz:

- **Tarixni o'qish:** `git log` (`--graph`, `--stat`, filtrlar bilan), `git show`, `git blame`.
- **`git diff`** — commitlar, teglar va ishchi katalog solishtirish.
- **SemVer** — major, minor yoki patch qachon oshadi.
- **Teglar** — lightweight va annotated turlari, qanday push/ochirilishi.
- **Relizlar** GitHubda: tavsif, arxivlar va `CHANGELOG.md` konventsiyasi.

---

## Amaliy vazifa

O'tgan darsdagi «tidy-project»ni versiyalanadigan loyihaga aylantiring:

1. Funksiyalar ishlab chiqayotganday 3–4 ta commit yarating (masalan, `index.html` qo'shing, keyin stil fixi).
2. Tarixni ko'ring: `git log --oneline --graph`.
3. Ikkita commitni solishtiring: `git diff <xesh-1>..<xesh-2>`.
4. Annotated teglar yarating: «yetarlicha barqaror»dan keyin `v1.0.0`, xato tuzatgach `v1.0.1`.
5. Nashrni simulyatsiya qiling: `git push origin --tags` (amaliyot skriptida remote lokal).
6. Har ikki versiya uchun yozuvlar bilan `CHANGELOG.md` yozing.

`practice-8.sh` skripti butun stsenariydan o'tkazadi:

---

[Keyingi dars: Git ish jarayonlari (workflows) →](../../Lesson-9/uz/Git%20ish%20jarayonlari%20(workflows).md)