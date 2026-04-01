/**
 * Hiển thị trạng thái loading hoặc error của trang.
 * @param {{ type?: 'loading'|'error', message: string, detail?: string }} props
 */
export default function LoadingState({ type = 'loading', message, detail }) {
  return (
    <div className="page-state">
      {type === 'error' ? (
        <>
          <p>{message}</p>
          {detail && <small>{detail}</small>}
        </>
      ) : (
        <p>{message}</p>
      )}
    </div>
  )
}
