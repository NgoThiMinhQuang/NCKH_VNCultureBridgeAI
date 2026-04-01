import './SectionHeading.css'

/**
 * Section heading với badge, tiêu đề và mô tả.
 * @param {{ badge: string, title: string, description: string }} props
 */
export default function SectionHeading({ badge, title, description }) {
  return (
    <div className="section-heading fade-up">
      <span className="section-badge">{badge}</span>
      <h2>{title}</h2>
      <p>{description}</p>
    </div>
  )
}
