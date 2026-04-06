import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import './HomePage.css'
import banner3 from '../../assets/banner3.jpg'
import { getHomepage } from '../../services/homepage.service'
import { searchArticles } from '../../services/content.service'
import { ui } from '../../i18n/messages'
import LoadingState from '../../components/common/LoadingState/LoadingState'
import PageHeader from '../../components/layout/PageHeader/PageHeader'
import Footer from '../../components/layout/Footer/Footer'

export default function HomePage() {
  const [lang, setLang] = useState('vi')
  const [homepage, setHomepage] = useState(null)
  const [status, setStatus] = useState('loading')
  const [error, setError] = useState('')
  const [search, setSearch] = useState('')
  const [results, setResults] = useState([])
  const [searching, setSearching] = useState(false)

  const copy = useMemo(() => ui[lang], [lang])

  function getHeroTitleLines(title) {
    if (!title) return []

    if (title === 'Khám phá vẻ đẹp văn hóa Việt Nam') {
      return ['Khám phá vẻ đẹp', 'văn hóa Việt Nam']
    }

    if (title === 'Discover the beauty of Vietnamese culture') {
      return ['Discover the beauty', 'of Vietnamese culture']
    }

    if (title.includes(' Việt Nam')) {
      return [title.replace(' Việt Nam', ''), 'Việt Nam']
    }

    if (title.includes(' Vietnam')) {
      return [title.replace(' Vietnam', ''), 'Vietnam']
    }

    const words = title.trim().split(/\s+/)
    const middle = Math.ceil(words.length / 2)
    return [words.slice(0, middle).join(' '), words.slice(middle).join(' ')]
  }

  useEffect(() => {
    let ignore = false
    async function loadHomepage() {
      try {
        setStatus('loading')
        setError('')
        const data = await getHomepage(lang)
        if (!ignore) {
          setHomepage(data)
          setStatus('success')
          document.documentElement.lang = lang
          document.title = lang === 'vi' ? 'VietCultura - Khám phá Việt Nam' : 'VietCultura - Discover Vietnam'
        }
      } catch (err) {
        if (!ignore) {
          setError(err.message)
          setStatus('error')
        }
      }
    }
    loadHomepage()
    return () => { ignore = true }
  }, [lang])

  async function handleSearch(event) {
    event.preventDefault()
    try {
      setSearching(true)
      const data = await searchArticles({ lang, q: search, limit: 6 })
      setResults(data)
    } finally {
      setSearching(false)
    }
  }

  if (status === 'loading') return <LoadingState message={copy.loading} />
  if (status === 'error') return <LoadingState type="error" message={copy.error} detail={error} />

  const homepageRegions = homepage.regions || []
  const ethnicShowcaseStats = copy.ethnicShowcaseStats || []
  const featuredEthnicGroups = (homepage.ethnicGroups || []).slice(0, 6)
  const heroTitleLines = getHeroTitleLines(homepage.hero.title)
  const festivalShowcaseCards = (homepage.festivals || []).slice(0, 3)
  const cuisineShowcaseCards = (homepage.cuisine || []).slice(0, 3)
  const artsShowcaseCards = homepage.arts || []
  const featuredArt = artsShowcaseCards[0]
  const additionalArts = artsShowcaseCards.slice(1, 7)
  const blogPosts = homepage.blogPosts || []
  const featuredBlogPost = blogPosts[0] || null
  const secondaryBlogPosts = blogPosts.slice(1, 4)
  const blogFilterPills = lang === 'vi'
    ? ['Tất cả', 'Du lịch', 'Văn hoá', 'Ẩm thực', 'Dân tộc', 'Nghệ thuật']
    : ['All', 'Travel', 'Culture', 'Cuisine', 'Ethnic Cultures', 'Arts']

  function formatBlogDate(value) {
    if (!value) return lang === 'vi' ? 'Mới đây' : 'Recently'

    const date = new Date(value)
    if (Number.isNaN(date.getTime())) return value

    return date.toLocaleDateString(lang === 'vi' ? 'vi-VN' : 'en-US', {
      month: 'long',
      day: 'numeric',
      year: 'numeric',
    })
  }

  function estimateReadMinutes(item, index) {
    const base = Math.max(5, Math.min(10, (item?.articleCount || 0) + 5))
    return `${base + index} ${lang === 'vi' ? 'phút đọc' : 'min read'}`
  }

  function getBlogCategoryLabel(item, index) {
    if (item?.category) return item.category
    return blogFilterPills[Math.min(index + 1, blogFilterPills.length - 1)]
  }

  function getBlogAuthorName(item, index) {
    if (lang === 'vi') return ['Minh Trần', 'Thu Hà', 'Quang Phạm', 'Linh Nguyễn'][index] || 'Biên tập viên'
    return ['Minh Tran', 'Thu Ha', 'Quang Pham', 'Linh Nguyen'][index] || 'Editorial team'
  }

  function getBlogAuthorInitials(name) {
    return name
      .split(/\s+/)
      .filter(Boolean)
      .slice(0, 2)
      .map((part) => part[0]?.toUpperCase() || '')
      .join('')
  }

  function getBlogAccent(index) {
    return ['red', 'purple', 'gold', 'green'][index % 4]
  }

  function localizeArtCategory(category) {
    if (!category) return ''

    const normalized = category.trim().toLowerCase()
    if (normalized === 'performing arts') return 'Nghệ thuật trình diễn'
    if (normalized === 'visual arts') return 'Mỹ thuật'
    if (normalized === 'musical heritage') return 'Di sản âm nhạc'
    if (normalized === 'folk arts') return 'Nghệ thuật dân gian'
    return category
  }

  function localizeArtTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'water puppetry') return 'Múa rối nước'
    if (normalized === 'lacquerware') return 'Sơn mài'
    if (normalized === 'bamboo crafts') return 'Thủ công tre'
    if (normalized === 'ao dai design') return 'Thiết kế áo dài'
    return title
  }

  function localizeCuisineTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'vietnamese banh mi') return 'Bánh mì Việt Nam'
    if (normalized === 'vietnamese pho') return 'Phở Việt Nam'
    return title
  }

  function localizeEthnicityTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'khmer') return 'Khmer'
    if (normalized === 'cham') return 'Chăm'
    return title
  }

  function localizeEthnicityDescription(description) {
    if (!description) return ''

    if (description.includes('The Khmer community is concentrated in southern Vietnam')) {
      return 'Cộng đồng Khmer tập trung chủ yếu ở Nam Bộ, nổi bật với chùa Phật giáo Nam tông, lễ hội truyền thống và nghệ thuật diễn xướng dân gian.'
    }

    return description
  }

  function localizeCuisineDescription(description) {
    if (!description) return ''

    if (description.includes('A famous sandwich born from the meeting of French baguette')) {
      return 'Món bánh mì trứ danh kết hợp tinh hoa baguette Pháp với nguyên liệu và hương vị rất Việt Nam.'
    }

    if (description.includes('An iconic Vietnamese dish known for clear broth')) {
      return 'Món phở biểu tượng của Việt Nam, nổi tiếng với nước dùng thanh, bánh phở mềm và hương vị hài hòa.'
    }

    return description
  }

  function localizeArtDescription(description) {
    if (!description) return ''

    if (description.includes('A distinctive performance art in which wooden puppets are controlled on water')) {
      return 'Loại hình nghệ thuật độc đáo nơi những con rối gỗ được điều khiển trên mặt nước, gắn với đời sống và trí tưởng tượng dân gian Việt.'
    }

    return description
  }

  function localizeFestivalTitle(title) {
    if (!title) return ''

    const normalized = title.trim().toLowerCase()
    if (normalized === 'hue festival') return 'Festival Huế'
    if (normalized === 'mid-autumn festival') return 'Tết Trung Thu'
    return title
  }

  function localizeFestivalSubtitle(subtitle) {
    if (!subtitle) return ''

    const normalized = subtitle.trim().toLowerCase()
    if (normalized === 'lunar new year') return 'Tết Nguyên Đán'
    if (normalized === 'mid-autumn festival') return 'Tết Trung Thu'
    if (normalized === 'hue festival') return 'Festival Huế'
    return subtitle
  }

  function localizeFestivalDescription(description) {
    if (!description) return ''

    if (description.includes('A large-scale cultural event honoring Hue heritage')) {
      return 'Sự kiện văn hóa quy mô lớn tôn vinh di sản Huế cùng các chương trình nghệ thuật đương đại đặc sắc.'
    }

    if (description.includes('A children-centered festival filled with lanterns')) {
      return 'Lễ hội dành cho thiếu nhi với đèn lồng, múa lân, bánh trung thu và không khí sum vầy dưới trăng rằm.'
    }

    return description
  }

  function localizeFestivalMeta(value) {
    if (!value) return ''

    const normalized = value.trim().toLowerCase()
    if (normalized === 'festival season') return 'Mùa lễ hội'
    if (normalized === 'central vietnam') return 'Miền Trung'
    if (normalized === 'nationwide') return 'Toàn quốc'
    return value
  }

  function localizeFestivalTag(tag) {
    if (!tag) return ''

    const normalized = tag.trim().toLowerCase()
    if (normalized === 'lantern parade') return 'Rước đèn'
    if (normalized === 'lion dance') return 'Múa lân'
    if (normalized === 'mooncakes') return 'Bánh trung thu'
    if (normalized === 'moon gazing') return 'Ngắm trăng'
    if (normalized === 'royal arts') return 'Nghệ thuật cung đình'
    if (normalized === 'night shows') return 'Trình diễn đêm'
    if (normalized === 'ao dai') return 'Áo dài'
    if (normalized === 'heritage performances') return 'Trình diễn di sản'
    return tag
  }

  function localizeFestivalBadge(badge) {
    if (!badge) return ''

    const normalized = badge.trim().toLowerCase()
    if (normalized === 'most important') return 'Nổi bật nhất'
    if (normalized === "children's festival") return 'Lễ hội thiếu nhi'
    if (normalized === 'cultural showcase') return 'Di sản trình diễn'
    return badge
  }

  function withSafeImage(item) {
    if (!item) return item

    return {
      ...item,
      imageUrl: item.imageUrl || null,
    }
  }

  function localizeEthnicityItem(item) {
    return {
      ...withSafeImage(item),
      title: localizeEthnicityTitle(item.title),
      description: localizeEthnicityDescription(item.description),
    }
  }

  function formatHomepageMetaPrimary(item) {
    if (item.publishedAt) {
      const date = new Date(item.publishedAt)
      if (!Number.isNaN(date.getTime())) {
        return date.toLocaleDateString(lang === 'vi' ? 'vi-VN' : 'en-US', {
          day: '2-digit',
          month: 'short',
        })
      }
    }

    if (item.articleCount) {
      return lang === 'vi' ? `${item.articleCount}+ bài viết` : `${item.articleCount}+ articles`
    }

    return lang === 'vi' ? 'Nội dung nổi bật' : 'Featured content'
  }

  function extractDynamicTags(...values) {
    const stopWords = new Set(['va', 'và', 'the', 'of', 'for', 'with', 'một', 'những', 'các'])

    return values
      .filter(Boolean)
      .flatMap((value) => String(value).replace(/[^\p{L}\p{N}\s-]/gu, ' ').split(/\s+/))
      .map((word) => word.trim())
      .filter((word) => word.length > 2)
      .filter((word) => !stopWords.has(word.toLowerCase()))
      .filter((word, index, array) => array.findIndex((entry) => entry.toLowerCase() === word.toLowerCase()) === index)
      .slice(0, 4)
  }

  function localizeCuisineItem(item) {
    const safeItem = withSafeImage(item)
    const title = localizeCuisineTitle(safeItem.title)
    const subtitle = safeItem.category || (lang === 'vi' ? 'Ẩm thực Việt Nam' : 'Vietnamese cuisine')
    const tags = extractDynamicTags(title, subtitle, safeItem.description)
    const rating = '★'.repeat(Math.max(3, Math.min(5, safeItem.articleCount || 4)))

    return {
      ...safeItem,
      title,
      subtitle,
      description: localizeCuisineDescription(safeItem.description),
      metaPrimary: formatHomepageMetaPrimary(safeItem),
      metaSecondary: safeItem.category || (lang === 'vi' ? 'Món nổi bật' : 'Featured dish'),
      tags,
      score: safeItem.articleCount ? `${safeItem.articleCount}+` : 'Top',
      scoreLabel: lang === 'vi' ? 'Món nổi bật' : 'Featured dish',
      cornerIcon: '🍽️',
      footerIcon: rating,
      spiceLevel: Math.max(1, Math.min(5, safeItem.articleCount || 3)),
    }
  }

  function localizeFestivalItem(item) {
    const safeItem = withSafeImage(item)
    const title = localizeFestivalTitle(safeItem.title)
    const subtitle = localizeFestivalSubtitle(safeItem.subtitle || safeItem.category || '')
    const tags = (safeItem.tags && safeItem.tags.length ? safeItem.tags : extractDynamicTags(title, subtitle, safeItem.description)).map(localizeFestivalTag)
    const rating = '★'.repeat(Math.max(3, Math.min(5, safeItem.articleCount || 4)))

    return {
      ...safeItem,
      title,
      subtitle,
      description: localizeFestivalDescription(safeItem.description),
      metaPrimary: localizeFestivalMeta(safeItem.metaPrimary || formatHomepageMetaPrimary(safeItem)),
      metaSecondary: localizeFestivalMeta(safeItem.metaSecondary || safeItem.category || (lang === 'vi' ? 'Lễ hội Việt Nam' : 'Vietnamese festival')),
      badge: localizeFestivalBadge(safeItem.badge || safeItem.category || (lang === 'vi' ? 'Lễ hội' : 'Festival')),
      badgeIcon: safeItem.badgeIcon || '✦',
      footerIcon: safeItem.footerIcon || rating,
      accent: safeItem.accent,
      tags,
    }
  }

  function formatFestivalRating(footerIcon) {
    const count = typeof footerIcon === 'string' ? (footerIcon.match(/★/g) || []).length : 0
    return count > 0 ? '★'.repeat(count) : ''
  }

  function getFestivalAccent(item, index) {
    if (item.accent) return item.accent
    return ['red', 'gold', 'purple'][index % 3]
  }

  function getFestivalBadgeIcon(item, index) {
    if (item.badgeIcon) return item.badgeIcon
    return ['✦', '✦', '✦'][index % 3]
  }

  function hasFestivalMeta(item) {
    return Boolean(item.metaPrimary || item.metaSecondary)
  }

  function hasFestivalTags(item) {
    return Array.isArray(item.tags) && item.tags.length > 0
  }

  function hasFestivalRating(item) {
    return Boolean(formatFestivalRating(item.footerIcon))
  }

  function hasFestivalBadge(item) {
    return Boolean(item.badge || item.category)
  }

  function hasFestivalCornerIcon(item) {
    return Boolean(item.badgeIcon)
  }

  function isFestivalCardRich(item) {
    return hasFestivalMeta(item) || hasFestivalTags(item) || hasFestivalRating(item) || hasFestivalBadge(item)
  }

  function getFestivalCardClass(item, index) {
    return `festival-card fade-up is-${getFestivalAccent(item, index)}${isFestivalCardRich(item) ? ' is-rich' : ''}`
  }

  function getFestivalMetaIcon(type) {
    return type === 'location' ? '📍' : '🗓️'
  }

  function getFestivalCornerIcon(item, index) {
    return hasFestivalCornerIcon(item) ? item.badgeIcon : ['✦', '✦', '✦'][index % 3]
  }

  function getFestivalBadgeLabel(item) {
    return item.badge || item.category || copy.festivalShowcaseBadge
  }

  function getFestivalRatingText(item) {
    return formatFestivalRating(item.footerIcon)
  }

  function getFestivalTags(item) {
    return item.tags || []
  }

  function getFestivalMetaItems(item) {
    return [
      item.metaPrimary ? { key: 'primary', icon: getFestivalMetaIcon('date'), value: item.metaPrimary } : null,
      item.metaSecondary ? { key: 'secondary', icon: getFestivalMetaIcon('location'), value: item.metaSecondary } : null,
    ].filter(Boolean)
  }

  function getFestivalDescription(item) {
    return item.description || ''
  }

  function getFestivalSubtitle(item) {
    return item.subtitle || ''
  }

  function getFestivalTitle(item) {
    return item.title || ''
  }

  function getFestivalImageAlt(item) {
    return item.imageAlt || item.title || 'Festival image'
  }

  function hasFestivalImage(item) {
    return Boolean(item.imageUrl)
  }

  function getFestivalLink(item) {
    return `/articles/${item.code}`
  }

  function getFestivalPlaceholder(item) {
    return item.title || 'Lễ hội'
  }

  function shouldShowFestivalFooter(item) {
    return Boolean(item.code)
  }

  function shouldShowFestivalSubtitle(item) {
    return Boolean(item.subtitle)
  }

  function shouldShowFestivalDescription(item) {
    return Boolean(item.description)
  }

  function shouldShowFestivalMeta(item) {
    return getFestivalMetaItems(item).length > 0
  }

  function shouldShowFestivalTags(item) {
    return getFestivalTags(item).length > 0
  }

  function shouldShowFestivalRating(item) {
    return Boolean(getFestivalRatingText(item))
  }

  function shouldShowFestivalBadge(item) {
    return Boolean(getFestivalBadgeLabel(item))
  }

  function shouldShowFestivalCorner(item) {
    return hasFestivalCornerIcon(item)
  }

  function getFestivalFooterClass(item) {
    return shouldShowFestivalRating(item) ? 'festival-card__footer' : 'festival-card__footer festival-card__footer--single'
  }

  function getFestivalMetaClass(item) {
    return getFestivalMetaItems(item).length > 1 ? 'festival-card__meta' : 'festival-card__meta festival-card__meta--single'
  }

  function getFestivalTagsClass(item) {
    return getFestivalTags(item).length > 0 ? 'festival-card__chips' : 'festival-card__chips festival-card__chips--empty'
  }

  function getFestivalMediaClass(item) {
    return hasFestivalImage(item) ? 'festival-card__image' : 'festival-card__image festival-card__image--placeholder'
  }

  function getFestivalRatingAria(item) {
    return getFestivalRatingText(item) ? `Đánh giá ${getFestivalRatingText(item)}` : ''
  }

  function getFestivalBadgeAria(item) {
    return getFestivalBadgeLabel(item)
  }

  function getFestivalCornerAria(item, index) {
    return getFestivalCornerIcon(item, index)
  }

  function getFestivalMetaAria(meta) {
    return meta.value
  }

  function getFestivalTagKey(tag, index) {
    return `${tag}-${index}`
  }

  function getFestivalCardKey(item, index) {
    return item.code || item.id || index
  }

  function getFestivalFallbackCta() {
    return copy.learnMore
  }

  function shouldShowFestivalLinkText() {
    return true
  }

  function getFestivalAccentClass(item, index) {
    return `is-${getFestivalAccent(item, index)}`
  }

  function getFestivalCardRichClass(item) {
    return isFestivalCardRich(item) ? 'is-rich' : ''
  }

  function joinFestivalCardClasses(item, index) {
    return ['festival-card', 'fade-up', getFestivalAccentClass(item, index), getFestivalCardRichClass(item)].filter(Boolean).join(' ')
  }

  function hasFestivalLink(item) {
    return Boolean(item.code)
  }

  function getFestivalCtaText() {
    return copy.learnMore
  }

  function getFestivalCtaArrow() {
    return '→'
  }

  function getFestivalBadgeText(item) {
    return getFestivalBadgeLabel(item)
  }

  function getFestivalBadgeIconText(item, index) {
    return getFestivalBadgeIcon(item, index)
  }

  function getFestivalCornerText(item, index) {
    return getFestivalCornerIcon(item, index)
  }

  function getFestivalMetaText(meta) {
    return meta.value
  }

  function getFestivalDescriptionText(item) {
    return getFestivalDescription(item)
  }

  function getFestivalSubtitleText(item) {
    return getFestivalSubtitle(item)
  }

  function getFestivalTitleText(item) {
    return getFestivalTitle(item)
  }

  function getFestivalPlaceholderText(item) {
    return getFestivalPlaceholder(item)
  }

  function getFestivalImageSrc(item) {
    return item.imageUrl
  }

  function getFestivalLinkHref(item) {
    return getFestivalLink(item)
  }

  function getFestivalRatingValue(item) {
    return getFestivalRatingText(item)
  }

  function getFestivalMetaList(item) {
    return getFestivalMetaItems(item)
  }

  function getFestivalTagList(item) {
    return getFestivalTags(item)
  }

  function showFestivalBadge(item) {
    return shouldShowFestivalBadge(item)
  }

  function showFestivalCorner(item) {
    return shouldShowFestivalCorner(item)
  }

  function showFestivalSubtitle(item) {
    return shouldShowFestivalSubtitle(item)
  }

  function showFestivalDescription(item) {
    return shouldShowFestivalDescription(item)
  }

  function showFestivalMeta(item) {
    return shouldShowFestivalMeta(item)
  }

  function showFestivalTags(item) {
    return shouldShowFestivalTags(item)
  }

  function showFestivalLink(item) {
    return hasFestivalLink(item)
  }

  function showFestivalRating(item) {
    return shouldShowFestivalRating(item)
  }

  function showFestivalImage(item) {
    return hasFestivalImage(item)
  }

  function showFestivalFooter(item) {
    return shouldShowFestivalFooter(item)
  }

  function getFestivalMetaItemClass() {
    return 'festival-card__meta-item'
  }

  function getFestivalRatingClass(item) {
    return showFestivalRating(item) ? 'festival-card__rating' : 'festival-card__rating is-hidden'
  }

  function getFestivalBadgeClass() {
    return 'festival-card__badge'
  }

  function getFestivalCornerClass(item) {
    return showFestivalCorner(item) ? 'festival-card__corner-icon' : 'festival-card__corner-icon is-hidden'
  }

  function getFestivalImageWrapperClass() {
    return 'festival-card__media'
  }

  function getFestivalBodyClass() {
    return 'festival-card__body'
  }

  function getFestivalTitleClass() {
    return 'festival-card__title'
  }

  function getFestivalSubtitleClass() {
    return 'festival-card__subtitle'
  }

  function getFestivalDescriptionClass() {
    return 'festival-card__description'
  }

  function getFestivalLinkClass() {
    return 'festival-card__cta'
  }

  function getFestivalPlaceholderClass() {
    return 'festival-card__image festival-card__image--placeholder'
  }

  function getFestivalImageClass() {
    return 'festival-card__image'
  }

  function getFestivalFooterTextClass() {
    return 'festival-card__footer-text'
  }

  function getFestivalBadgeInnerClass() {
    return 'festival-card__badge-text'
  }

  function getFestivalCornerInnerClass() {
    return 'festival-card__corner-text'
  }

  function getFestivalMetaValueClass() {
    return 'festival-card__meta-value'
  }

  function getFestivalMetaIconClass() {
    return 'festival-card__meta-icon'
  }

  function getFestivalTagClass() {
    return 'festival-card__tag'
  }

  function getFestivalFooterRatingClass() {
    return 'festival-card__rating'
  }

  function getFestivalFooterLinkClass() {
    return 'festival-card__cta'
  }

  function getFestivalFooterArrowClass() {
    return 'festival-card__cta-arrow'
  }

  function getFestivalBadgeIconClass() {
    return 'festival-card__badge-icon'
  }

  function getFestivalBadgeTextClass() {
    return 'festival-card__badge-label'
  }

  function getFestivalCornerIconClass() {
    return 'festival-card__corner-label'
  }

  function getFestivalTitleHeadingClass() {
    return 'festival-card__heading'
  }

  function getFestivalDescriptionParagraphClass() {
    return 'festival-card__copy'
  }

  function getFestivalMetaWrapperClass(item) {
    return getFestivalMetaClass(item)
  }

  function getFestivalTagsWrapperClass(item) {
    return getFestivalTagsClass(item)
  }

  function getFestivalFooterWrapperClass(item) {
    return getFestivalFooterClass(item)
  }

  function getFestivalCardWrapperClass(item, index) {
    return joinFestivalCardClasses(item, index)
  }

  function getFestivalRatingDisplay(item) {
    return getFestivalRatingValue(item)
  }

  function getFestivalMetaDisplay(meta) {
    return getFestivalMetaText(meta)
  }

  function getFestivalBadgeDisplay(item) {
    return getFestivalBadgeText(item)
  }

  function getFestivalCornerDisplay(item, index) {
    return getFestivalCornerText(item, index)
  }

  function getFestivalTitleDisplay(item) {
    return getFestivalTitleText(item)
  }

  function getFestivalSubtitleDisplay(item) {
    return getFestivalSubtitleText(item)
  }

  function getFestivalDescriptionDisplay(item) {
    return getFestivalDescriptionText(item)
  }

  function getFestivalPlaceholderDisplay(item) {
    return getFestivalPlaceholderText(item)
  }

  function getFestivalBadgeIconDisplay(item, index) {
    return getFestivalBadgeIconText(item, index)
  }

  function getFestivalCtaDisplay() {
    return getFestivalCtaText()
  }

  function getFestivalArrowDisplay() {
    return getFestivalCtaArrow()
  }

  function getFestivalImageDisplay(item) {
    return getFestivalImageSrc(item)
  }

  function getFestivalLinkDisplay(item) {
    return getFestivalLinkHref(item)
  }

  function getFestivalCardDisplayKey(item, index) {
    return getFestivalCardKey(item, index)
  }

  function getFestivalTagDisplayKey(tag, index) {
    return getFestivalTagKey(tag, index)
  }

  function getFestivalMetaDisplayAria(meta) {
    return getFestivalMetaAria(meta)
  }

  function getFestivalBadgeDisplayAria(item) {
    return getFestivalBadgeAria(item)
  }

  function getFestivalCornerDisplayAria(item, index) {
    return getFestivalCornerAria(item, index)
  }

  function getFestivalRatingDisplayAria(item) {
    return getFestivalRatingAria(item)
  }

  function getFestivalImageDisplayAlt(item) {
    return getFestivalImageAlt(item)
  }

  function shouldUseFestivalPlaceholder(item) {
    return !showFestivalImage(item)
  }

  function shouldRenderFestivalMediaOverlay() {
    return true
  }

  function shouldRenderFestivalBody() {
    return true
  }

  function shouldRenderFestivalTitle(item) {
    return Boolean(getFestivalTitleDisplay(item))
  }

  function shouldRenderFestivalCta() {
    return shouldShowFestivalLinkText()
  }

  function shouldRenderFestivalArrow() {
    return true
  }

  function shouldRenderFestivalMetaIcon() {
    return true
  }

  function shouldRenderFestivalTag(tag) {
    return Boolean(tag)
  }

  function shouldRenderFestivalBadgeIcon() {
    return true
  }

  function shouldRenderFestivalCornerIcon(item) {
    return showFestivalCorner(item)
  }

  function shouldRenderFestivalRatingValue(item) {
    return showFestivalRating(item)
  }

  function shouldRenderFestivalMetaValue(meta) {
    return Boolean(meta.value)
  }

  function shouldRenderFestivalLink(item) {
    return showFestivalLink(item)
  }

  function shouldRenderFestivalFooter(item) {
    return showFestivalFooter(item)
  }

  function shouldRenderFestivalTags(item) {
    return showFestivalTags(item)
  }

  function shouldRenderFestivalMeta(item) {
    return showFestivalMeta(item)
  }

  function shouldRenderFestivalDescription(item) {
    return showFestivalDescription(item)
  }

  function shouldRenderFestivalSubtitle(item) {
    return showFestivalSubtitle(item)
  }

  function shouldRenderFestivalBadge(item) {
    return showFestivalBadge(item)
  }

  function shouldRenderFestivalImage(item) {
    return showFestivalImage(item)
  }

  function shouldRenderFestivalPlaceholder(item) {
    return shouldUseFestivalPlaceholder(item)
  }

  function shouldRenderFestivalTitleHeading(item) {
    return shouldRenderFestivalTitle(item)
  }

  function shouldRenderFestivalCard(item) {
    return Boolean(item)
  }

  function shouldRenderFestivalCardList(items) {
    return Array.isArray(items) && items.length > 0
  }

  function shouldRenderFestivalSection() {
    return true
  }

  function shouldRenderFestivalMedia() {
    return true
  }

  function shouldRenderFestivalBodyWrapper() {
    return true
  }

  function shouldRenderFestivalFooterWrapper(item) {
    return shouldRenderFestivalFooter(item)
  }

  function shouldRenderFestivalMetaWrapper(item) {
    return shouldRenderFestivalMeta(item)
  }

  function shouldRenderFestivalTagsWrapper(item) {
    return shouldRenderFestivalTags(item)
  }

  function shouldRenderFestivalBadgeWrapper(item) {
    return shouldRenderFestivalBadge(item)
  }

  function shouldRenderFestivalCornerWrapper(item) {
    return shouldRenderFestivalCornerIcon(item)
  }

  function shouldRenderFestivalLinkWrapper(item) {
    return shouldRenderFestivalLink(item)
  }

  function shouldRenderFestivalRatingWrapper(item) {
    return shouldRenderFestivalRatingValue(item)
  }

  function shouldRenderFestivalMetaItem(meta) {
    return shouldRenderFestivalMetaValue(meta)
  }

  function shouldRenderFestivalTagItem(tag) {
    return shouldRenderFestivalTag(tag)
  }

  function shouldRenderFestivalBadgeText(item) {
    return Boolean(getFestivalBadgeDisplay(item))
  }

  function shouldRenderFestivalCornerText(item, index) {
    return Boolean(getFestivalCornerDisplay(item, index))
  }

  function shouldRenderFestivalCtaText() {
    return true
  }

  function shouldRenderFestivalArrowText() {
    return true
  }

  function shouldRenderFestivalImageAlt(item) {
    return Boolean(getFestivalImageDisplayAlt(item))
  }

  function shouldRenderFestivalImageSrc(item) {
    return Boolean(getFestivalImageDisplay(item))
  }

  function shouldRenderFestivalLinkHref(item) {
    return Boolean(getFestivalLinkDisplay(item))
  }

  function shouldRenderFestivalCardKey(item, index) {
    return Boolean(getFestivalCardDisplayKey(item, index))
  }

  function shouldRenderFestivalTagKey(tag, index) {
    return Boolean(getFestivalTagDisplayKey(tag, index))
  }

  function shouldRenderFestivalAriaValue(value) {
    return Boolean(value)
  }

  function shouldRenderFestivalClassName(value) {
    return Boolean(value)
  }

  function shouldRenderFestivalAccent(item, index) {
    return Boolean(getFestivalAccentClass(item, index))
  }

  function shouldRenderFestivalRich(item) {
    return Boolean(getFestivalCardRichClass(item))
  }

  function localizeArtItem(item) {
    return {
      ...withSafeImage(item),
      title: localizeArtTitle(item.title),
      category: localizeArtCategory(item.category),
      description: localizeArtDescription(item.description),
    }
  }

  const localizedCuisineShowcaseCards = cuisineShowcaseCards.map(localizeCuisineItem)
  const localizedFestivalShowcaseCards = festivalShowcaseCards.map(localizeFestivalItem)
  const localizedFeaturedEthnicGroups = featuredEthnicGroups.map(localizeEthnicityItem)
  const localizedFeaturedArt = featuredArt ? localizeArtItem(featuredArt) : null
  const localizedAdditionalArts = additionalArts.map(localizeArtItem)
  const localizedArtsTabs = artsShowcaseCards.slice(0, 3).map(localizeArtItem)

  return (
    <div className="page-shell">
      <PageHeader
        lang={lang}
        onLangChange={setLang}
        renderNav={() => (
          <nav className="ph__nav" aria-label="Main navigation">
            <a href="#hero" className="ph__nav-link">{copy.nav[0]}</a>
            <Link to="/regions" className="ph__nav-link">{copy.nav[1]}</Link>
            <Link to="/ethnic-groups" className="ph__nav-link">{copy.nav[2]}</Link>
            <Link to="/festivals" className="ph__nav-link">{copy.nav[3]}</Link>
            <Link to="/cuisine" className="ph__nav-link">{copy.nav[4]}</Link>
            <Link to="/articles" className="ph__nav-link">{copy.nav[5]}</Link>
            <Link to="/blog" className="ph__nav-link">{copy.nav[6]}</Link>
          </nav>
        )}
      />

      <main>
        <section
          className="hero-section"
          id="hero"
          style={{
            backgroundImage: `linear-gradient(rgba(30, 15, 10, 0.26), rgba(30, 15, 10, 0.4)), url(${banner3})`,
          }}
        >
          <div className="hero-content hero-content--animated">
            <span className="section-badge">{homepage.hero.badge}</span>
            <h1>
              {heroTitleLines.map((line, index) => (
                <span key={`${line}-${index}`} className="hero-title-line">
                  {line}
                </span>
              ))}
            </h1>
            <p>{homepage.hero.subtitle}</p>
            <div className="hero-actions">
              <Link to="/regions" className="primary-button nav-link-button hero-action-button">{homepage.hero.primaryCta}</Link>
              <a href="#festivals" className="secondary-button nav-link-button hero-action-button">{homepage.hero.secondaryCta}</a>
            </div>
            <form className="ai-guide__composer search-bar glass-panel hero-search-bar" onSubmit={handleSearch}>
              <input
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                placeholder={lang === 'vi' ? 'Tìm kiếm bài viết, vùng miền, món ăn...' : 'Search articles, regions, dishes...'}
              />
              <button
                type="submit"
                className="gradient-button nav-link-button hero-search-submit"
                disabled={searching}
                aria-label={copy.search}
              >
                <svg viewBox="0 0 24 24" focusable="false" aria-hidden="true">
                  <path d="M10.5 4a6.5 6.5 0 1 0 4.03 11.6l4.43 4.43 1.06-1.06-4.43-4.43A6.5 6.5 0 0 0 10.5 4Zm0 1.5a5 5 0 1 1 0 10 5 5 0 0 1 0-10Z" />
                </svg>
              </button>
            </form>
            {results.length ? (
              <div className="search-results fade-up">
                <CardGrid items={results} variant="blog-grid" actionLabel={copy.learnMore} lang={lang} basePath="/articles" />
              </div>
            ) : null}
            <div className="stats-row">
              {homepage.stats.map((stat) => (
                <div key={stat.label} className="stat-card float-card">
                  <strong>{stat.value}</strong>
                  <span>{stat.label}</span>
                </div>
              ))}
            </div>
          </div>
        </section>

        <div className="page-content-shell">
          <section className="content-section regions-section regions-showcase" id="regions">
            <div className="regions-showcase__heading fade-up">
              <span className="regions-showcase__eyebrow">
                <span className="regions-showcase__eyebrow-star" aria-hidden="true">✦</span>
                <span>Khám phá Việt Nam</span>
                <span className="regions-showcase__eyebrow-star" aria-hidden="true">✦</span>
              </span>
              <h2>Ba miền văn hóa đặc sắc</h2>
              <p>
                Từ miền núi phía Bắc đến dải đất miền Trung và vùng sông nước phương Nam, mỗi miền đều có bản sắc,
                nhịp sống và vẻ đẹp riêng để bạn khám phá.
              </p>
            </div>

            <div className="regions-showcase__grid">
              {homepageRegions.map((region) => (
                <article key={region.code || region.id} className={`region-showcase-card fade-up ${region.accentClass || ''}`}>
                  {region.imageUrl ? (
                    <img src={region.imageUrl} alt={region.imageAlt} className="region-showcase-card__image" />
                  ) : (
                    <div className="region-showcase-card__image region-showcase-card__image--placeholder">
                      {region.title}
                    </div>
                  )}

                  <div className="region-showcase-card__overlay" />

                  <div className="region-showcase-card__content">
                    <div className="region-showcase-card__top">
                      <span className="region-showcase-card__badge">{region.badge}</span>
                      <span className="region-showcase-card__number">{region.number}</span>
                    </div>

                    <div className="region-showcase-card__body">
                      <h3>{region.title}</h3>
                      <p className="region-showcase-card__description">{region.description}</p>

                      <div className="region-showcase-card__chips">
                        {region.highlights.map((item) => (
                          <span key={item}>{item}</span>
                        ))}
                      </div>
                    </div>

                    <Link to={`/regions/${region.code}`} className="region-showcase-card__cta">
                      {region.cta}
                      <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </article>
              ))}
            </div>

            <div className="regions-showcase__footer fade-up">
              <Link to="/regions" className="regions-showcase__button">
                <span>Xem bản đồ đầy đủ</span>
                <svg viewBox="0 0 24 24" focusable="false" aria-hidden="true">
                  <path d="M12 22s7-4.35 7-11a7 7 0 1 0-14 0c0 6.65 7 11 7 11Zm0-9a2 2 0 1 1 0-4 2 2 0 0 1 0 4Z" />
                </svg>
              </Link>
            </div>
          </section>

          <section className="content-section dark-section ethnic-showcase" id="ethnic-groups">
            <div className="ethnic-showcase__header fade-up">
              <span className="ethnic-showcase__eyebrow">
                <span className="ethnic-showcase__eyebrow-star" aria-hidden="true">✦</span>
                <span>{copy.ethnicShowcaseBadge}</span>
                <span className="ethnic-showcase__eyebrow-star" aria-hidden="true">✦</span>
              </span>
              <h2>{copy.ethnicShowcaseTitle}</h2>
              <p>{copy.ethnicShowcaseDescription}</p>
            </div>

            <div className="ethnic-showcase__stats">
              {ethnicShowcaseStats.map((stat) => (
                <div key={stat.label} className="ethnic-stat-card float-card">
                  <div className="ethnic-stat-card__value">
                    <span className="ethnic-stat-card__icon" aria-hidden="true">{stat.icon}</span>
                    <strong>{stat.value}</strong>
                  </div>
                  <span className="ethnic-stat-card__label">{stat.label}</span>
                </div>
              ))}
            </div>

            <div className="ethnic-showcase__grid">
              {localizedFeaturedEthnicGroups.map((item, index) => (
                <article key={item.code || item.id || index} className="ethnic-card fade-up">
                  {item.imageUrl ? (
                    <img src={item.imageUrl} alt={item.imageAlt || item.title} className="ethnic-card__image" />
                  ) : (
                    <div className="ethnic-card__image ethnic-card__image--placeholder">{item.title}</div>
                  )}

                  <div className="ethnic-card__overlay" />

                  <div className="ethnic-card__content">
                    <div className="ethnic-card__top">
                      <span className="ethnic-card__count">{item.articleCount ? `${item.articleCount}+ ${copy.ethnicShowcaseCountLabel}` : copy.ethnicShowcaseCountLabel}</span>
                    </div>

                    <div className="ethnic-card__body">
                      <h3>{item.title}</h3>
                      {item.description ? <p>{item.description}</p> : null}
                    </div>

                    <Link to={`/ethnic-groups/${item.code}`} className="ethnic-card__cta">
                      {copy.ethnicShowcaseSecondaryCta}
                      <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </article>
              ))}
            </div>

            <div className="ethnic-showcase__footer fade-up">
              <Link to="/ethnic-groups" className="ethnic-showcase__button">
                <span>{copy.ethnicShowcasePrimaryCta}</span>
                <span aria-hidden="true">→</span>
              </Link>
            </div>
          </section>

          <section className="content-section light-section festival-showcase" id="festivals">
            <div className="festival-showcase__header fade-up">
              <span className="festival-showcase__eyebrow">
                <span className="festival-showcase__eyebrow-star" aria-hidden="true">✦</span>
                <span>{copy.festivalShowcaseBadge}</span>
                <span className="festival-showcase__eyebrow-star" aria-hidden="true">✦</span>
              </span>
              <h2>
                <span>{copy.festivalShowcaseTitle}</span>{' '}
                <span className="festival-showcase__title-accent">{copy.festivalShowcaseTitleAccent}</span>
              </h2>
              <div className="festival-showcase__divider" aria-hidden="true">
                <span />
                <i />
                <b />
                <span />
              </div>
              <p>{copy.festivalShowcaseDescription}</p>
            </div>

            <div className="festival-showcase__grid">
              {localizedFestivalShowcaseCards.map((item, index) => {
                const accent = getFestivalAccent(item, index)
                const badgeIcon = getFestivalBadgeIcon(item, index)
                const badgeLabel = item.badge || item.category || copy.festivalShowcaseBadge
                const metaItems = [
                  item.metaPrimary ? { key: 'primary', icon: '🗓️', value: item.metaPrimary } : null,
                  item.metaSecondary ? { key: 'secondary', icon: '📍', value: item.metaSecondary } : null,
                ].filter(Boolean)
                const tags = item.tags || []
                const rating = formatFestivalRating(item.footerIcon)

                return (
                  <article key={item.code || item.id || index} className={`festival-card fade-up is-${accent}`}>
                    <div className="festival-card__media">
                      {item.imageUrl ? (
                        <img src={item.imageUrl} alt={item.imageAlt || item.title} className="festival-card__image" />
                      ) : (
                        <div className="festival-card__image festival-card__image--placeholder">{item.title}</div>
                      )}

                      {badgeLabel ? (
                        <span className="festival-card__badge" aria-label={badgeLabel}>
                          <span aria-hidden="true">{badgeIcon}</span>
                          <span>{badgeLabel}</span>
                        </span>
                      ) : null}

                      {item.badgeIcon ? <span className="festival-card__corner-icon" aria-hidden="true">{item.badgeIcon}</span> : null}
                    </div>

                    <div className="festival-card__body">
                      <h3>{item.title}</h3>
                      {item.subtitle ? <p className="festival-card__subtitle">{item.subtitle}</p> : null}
                      {item.description ? <p className="festival-card__description">{item.description}</p> : null}

                      {metaItems.length ? (
                        <div className="festival-card__meta">
                          {metaItems.map((meta) => (
                            <span key={meta.key}>
                              <span aria-hidden="true">{meta.icon}</span>
                              <span>{meta.value}</span>
                            </span>
                          ))}
                        </div>
                      ) : null}

                      {tags.length ? (
                        <div className="festival-card__chips">
                          {tags.map((tag, tagIndex) => (
                            <span key={`${tag}-${tagIndex}`}>{tag}</span>
                          ))}
                        </div>
                      ) : null}

                      {item.code ? (
                        <div className="festival-card__footer">
                          <Link to={`/articles/${item.code}`} className="festival-card__cta">
                            {copy.learnMore}
                            <span aria-hidden="true">→</span>
                          </Link>
                          {rating ? <span className="festival-card__rating" aria-hidden="true">{rating}</span> : null}
                        </div>
                      ) : null}
                    </div>
                  </article>
                )
              })}
            </div>
          </section>

          <section className="content-section light-section cuisine-showcase" id="cuisine">
            <div className="cuisine-showcase__header fade-up">
              <span className="cuisine-showcase__eyebrow">
                <span className="cuisine-showcase__eyebrow-star" aria-hidden="true">✦</span>
                <span>{copy.cuisineShowcaseBadge}</span>
                <span className="cuisine-showcase__eyebrow-star" aria-hidden="true">✦</span>
              </span>
              <h2>
                <span>{copy.cuisineShowcaseTitle}</span>{' '}
                <span className="cuisine-showcase__title-accent">{copy.cuisineShowcaseTitleAccent}</span>
              </h2>
              <div className="cuisine-showcase__divider" aria-hidden="true">
                <span />
                <i />
                <b />
                <span />
              </div>
              <p>{copy.cuisineShowcaseDescription}</p>
              <div className="cuisine-showcase__filters">
                <span className="cuisine-showcase__filters-label">{copy.cuisineShowcaseFilterLabel}</span>
                {copy.cuisineShowcaseFilters.map((filter) => (
                  <span key={filter} className="cuisine-showcase__filter-pill">{filter}</span>
                ))}
              </div>
            </div>

            <div className="cuisine-showcase__grid">
              {localizedCuisineShowcaseCards.map((item, index) => (
                <article key={item.code || item.id || index} className="cuisine-card fade-up">
                  <div className="cuisine-card__media">
                    {item.imageUrl ? (
                      <img src={item.imageUrl} alt={item.imageAlt || item.title} className="cuisine-card__image" />
                    ) : (
                      <div className="cuisine-card__image cuisine-card__image--placeholder">{item.title}</div>
                    )}

                    <span className="cuisine-card__score">{item.scoreLabel}</span>
                    <button type="button" className="cuisine-card__favorite" aria-label={item.title}>
                      {item.cornerIcon}
                    </button>
                    <span className="cuisine-card__spice">
                      {'🔥'.repeat(item.spiceLevel || 1)}
                      {'🖤'.repeat(Math.max(0, 5 - (item.spiceLevel || 1)))}
                    </span>
                  </div>

                  <div className="cuisine-card__body">
                    <h3>{item.title}</h3>
                    <p className="cuisine-card__subtitle">{item.subtitle}</p>
                    {item.description ? <p className="cuisine-card__description">{item.description}</p> : null}

                    <div className="cuisine-card__meta">
                      <span>
                        <span aria-hidden="true">🗓️</span>
                        <span>{item.metaPrimary}</span>
                      </span>
                      <span>
                        <span aria-hidden="true">📍</span>
                        <span>{item.metaSecondary}</span>
                      </span>
                    </div>

                    <div className="cuisine-card__chips">
                      {(item.tags || []).map((tag) => (
                        <span key={tag}>{tag}</span>
                      ))}
                    </div>

                    <div className="cuisine-card__footer">
                      <Link to={`/articles/${item.code}`} className="cuisine-card__cta">
                        {copy.learnMore}
                        <span aria-hidden="true">→</span>
                      </Link>
                      <span className="cuisine-card__rating" aria-hidden="true">{item.footerIcon}</span>
                    </div>
                  </div>
                </article>
              ))}
            </div>

            <div className="cuisine-showcase__footer fade-up">
              <Link to="/articles" className="cuisine-showcase__button">
                <span>{copy.cuisineShowcaseSectionCta}</span>
                <span aria-hidden="true">→</span>
              </Link>
            </div>
          </section>

          <section className="content-section light-section arts-layout arts-showcase" id="arts">
            {localizedFeaturedArt ? (
              <>
                <div className="arts-showcase__header fade-up">
                  <span className="arts-showcase__eyebrow">
                    <span className="arts-showcase__eyebrow-star" aria-hidden="true">✦</span>
                    <span>{copy.artsSectionBadge}</span>
                    <span className="arts-showcase__eyebrow-star" aria-hidden="true">✦</span>
                  </span>
                  <h2>{copy.artsSectionTitle}</h2>
                  <div className="arts-showcase__divider" aria-hidden="true">
                    <span />
                    <i />
                    <b />
                    <span />
                  </div>
                  <p>{copy.artsSectionDescription}</p>
                </div>

                <div className="arts-showcase__tabs fade-up">
                  {localizedArtsTabs.map((item, index) => (
                    <button
                      key={item.code || item.id || index}
                      type="button"
                      className={`arts-showcase__tab ${index === 0 ? 'is-active' : ''}`}
                    >
                      <span className="arts-showcase__tab-title">{item.title}</span>
                      {item.category ? <span className="arts-showcase__tab-category">{item.category}</span> : null}
                    </button>
                  ))}
                </div>

                <div className="arts-showcase__hero fade-up">
                  <div className="arts-showcase__hero-media">
                    {localizedFeaturedArt.imageUrl ? (
                      <img src={localizedFeaturedArt.imageUrl} alt={localizedFeaturedArt.imageAlt || localizedFeaturedArt.title} className="arts-showcase__hero-image" />
                    ) : (
                      <div className="arts-showcase__hero-image arts-showcase__hero-image--placeholder">{localizedFeaturedArt.title}</div>
                    )}
                    {localizedFeaturedArt.category ? <span className="arts-showcase__hero-badge">{localizedFeaturedArt.category}</span> : null}
                    <button type="button" className="arts-showcase__hero-play" aria-label="Phát video giới thiệu">
                      ▶
                    </button>
                  </div>

                  <div className="arts-showcase__hero-body">
                    {localizedFeaturedArt.category ? <span className="arts-showcase__hero-kicker">{localizedFeaturedArt.category}</span> : null}
                    <h2>{localizedFeaturedArt.title}</h2>
                    <span className="arts-showcase__hero-line" aria-hidden="true" />
                    {localizedFeaturedArt.description ? <p>{localizedFeaturedArt.description}</p> : null}

                    <div className="arts-showcase__hero-chips">
                      {[
                        localizedFeaturedArt.category,
                        localizedFeaturedArt.publishedAt ? 'Tư liệu nổi bật' : null,
                        localizedFeaturedArt.articleCount ? `${localizedFeaturedArt.articleCount}+ bài viết` : 'Khám phá di sản',
                      ].filter(Boolean).slice(0, 3).map((chip) => (
                        <span key={chip}>{chip}</span>
                      ))}
                    </div>

                    <Link to={`/articles/${localizedFeaturedArt.code}`} className="arts-showcase__hero-cta">
                      {`Xem ${localizedFeaturedArt.title}`}
                      <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </div>

                {localizedAdditionalArts.length ? (
                  <div className="arts-showcase__more fade-up">
                    <h3>Thêm nghệ thuật & thủ công truyền thống</h3>
                    <div className="arts-showcase__mini-grid">
                      {localizedAdditionalArts.map((item, index) => (
                        <Link
                          key={item.code || item.id || index}
                          to={`/articles/${item.code}`}
                          className="arts-showcase__mini-card"
                        >
                          <span className={`arts-showcase__mini-icon arts-showcase__mini-icon--${index + 1}`} aria-hidden="true">
                            <span className="arts-showcase__mini-icon-mark" />
                          </span>
                          <strong>{item.title}</strong>
                          {item.description ? <span>{item.description}</span> : null}
                        </Link>
                      ))}
                    </div>
                  </div>
                ) : null}
              </>
            ) : null}
          </section>

          <section className="content-section light-section blog-showcase" id="blog">
            <div className="blog-showcase__header fade-up">
              <span className="blog-showcase__eyebrow">
                <span aria-hidden="true">✦</span>
                <span>{copy.blogSectionBadge}</span>
                <span aria-hidden="true">✦</span>
              </span>
              <h2>
                <span>{lang === 'vi' ? 'Từ' : 'From Our'}</span>{' '}
                <span className="blog-showcase__title-accent">{lang === 'vi' ? 'Blog' : 'Blog'}</span>
              </h2>
              <div className="blog-showcase__divider" aria-hidden="true">
                <span />
                <i />
                <b />
                <span />
              </div>
              <p>{copy.blogSectionDescription}</p>
              <div className="blog-showcase__filters">
                {blogFilterPills.map((pill, index) => (
                  <button
                    key={pill}
                    type="button"
                    className={`blog-showcase__filter ${index === 0 ? 'is-active' : ''}`}
                  >
                    {pill}
                  </button>
                ))}
              </div>
            </div>

            {featuredBlogPost ? (
              <article className="blog-showcase__featured fade-up">
                <div className="blog-showcase__featured-media">
                  {featuredBlogPost.imageUrl ? (
                    <img src={featuredBlogPost.imageUrl} alt={featuredBlogPost.imageAlt || featuredBlogPost.title} className="blog-showcase__featured-image" />
                  ) : (
                    <div className="blog-showcase__featured-image blog-showcase__featured-image--placeholder">{featuredBlogPost.title}</div>
                  )}
                  <span className="blog-showcase__featured-badge">✦ {lang === 'vi' ? 'Nổi bật' : 'Featured'}</span>
                </div>
                <div className="blog-showcase__featured-body">
                  <div className="blog-showcase__featured-meta-top">
                    <span className="blog-showcase__featured-category">{getBlogCategoryLabel(featuredBlogPost, 0)}</span>
                    <span className="blog-showcase__featured-read">◷ {estimateReadMinutes(featuredBlogPost, 0)}</span>
                  </div>
                  <h3>{featuredBlogPost.title}</h3>
                  {featuredBlogPost.description ? <p>{featuredBlogPost.description}</p> : null}
                  <div className="blog-showcase__featured-footer">
                    <div className="blog-showcase__author">
                      <span className="blog-showcase__author-avatar">{getBlogAuthorInitials(getBlogAuthorName(featuredBlogPost, 3))}</span>
                      <span>
                        <strong>{getBlogAuthorName(featuredBlogPost, 3)}</strong>
                        <small>{formatBlogDate(featuredBlogPost.publishedAt)}</small>
                      </span>
                    </div>
                    <Link to={`/articles/${featuredBlogPost.code}`} className="blog-showcase__readmore">
                      {lang === 'vi' ? 'Xem thêm' : 'Read More'}
                      <span aria-hidden="true">→</span>
                    </Link>
                  </div>
                </div>
              </article>
            ) : null}

            {secondaryBlogPosts.length ? (
              <div className="blog-showcase__grid fade-up">
                {secondaryBlogPosts.map((item, index) => {
                  const authorName = getBlogAuthorName(item, index)
                  const accent = getBlogAccent(index)

                  return (
                    <article key={item.code || item.id || index} className={`blog-card is-${accent}`}>
                      <div className="blog-card__media">
                        {item.imageUrl ? (
                          <img src={item.imageUrl} alt={item.imageAlt || item.title} className="blog-card__image" />
                        ) : (
                          <div className="blog-card__image blog-card__image--placeholder">{item.title}</div>
                        )}
                        <span className="blog-card__badge">{getBlogCategoryLabel(item, index + 1)}</span>
                      </div>
                      <div className="blog-card__body">
                        <div className="blog-card__meta-top">◷ {estimateReadMinutes(item, index + 1)} · {formatBlogDate(item.publishedAt)}</div>
                        <h3>{item.title}</h3>
                        {item.description ? <p>{item.description}</p> : null}
                        <div className="blog-card__footer">
                          <div className="blog-card__author">
                            <span className="blog-card__author-avatar">{getBlogAuthorInitials(authorName)}</span>
                            <strong>{authorName}</strong>
                          </div>
                          <Link to={`/articles/${item.code}`} className="blog-card__readmore">
                            {lang === 'vi' ? 'Đọc' : 'Read'}
                            <span aria-hidden="true">→</span>
                          </Link>
                        </div>
                      </div>
                    </article>
                  )
                })}
              </div>
            ) : null}

            <div className="blog-showcase__footer fade-up">
              <Link to="/blog" className="blog-showcase__button">
                <span>{copy.viewAll}</span>
              </Link>
            </div>
          </section>
        </div>
      </main>

      <Footer lang={lang} />
    </div>
  )
}
