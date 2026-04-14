import './App.css'
import AppRouter from './router/AppRouter'
import { LanguageProvider } from './context/LanguageContext'

export default function App() {
  return (
    <LanguageProvider>
      <AppRouter />
    </LanguageProvider>
  )
}
