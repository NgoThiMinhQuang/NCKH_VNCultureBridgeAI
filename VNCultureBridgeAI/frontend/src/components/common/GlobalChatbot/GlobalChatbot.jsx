import React, { useState, useEffect, useRef } from 'react';
import { getGeminiChatSession } from '../../../services/gemini';
import { FaRobot, FaUser, FaTimes, FaPaperPlane } from 'react-icons/fa';
import { RiDoubleQuotesL } from 'react-icons/ri';
import './GlobalChatbot.css';

export default function GlobalChatbot() {
  const [isOpen, setIsOpen] = useState(false);
  const [question, setQuestion] = useState('');
  const [history, setHistory] = useState([]);
  const [loading, setLoading] = useState(false);
  
  const messagesEndRef = useRef(null);
  const chatSessionRef = useRef(null);

  const toggleChat = () => {
    setIsOpen(!isOpen);
    
    // Khởi tạo Chat Session ngay không cần yêu cầu đăng nhập
    if (!chatSessionRef.current) {
      const apiKey = import.meta.env.VITE_GEMINI_API_KEY || '';
      if (apiKey) {
        chatSessionRef.current = getGeminiChatSession(apiKey);
      } else {
        console.error("Lỗi: Chưa cấu hình biến môi trường VITE_GEMINI_API_KEY trong file .env!");
      }
    }
  };

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    if (isOpen) {
      scrollToBottom();
    }
  }, [history, isOpen, loading]);

  useEffect(() => {
    const handleOpenChat = () => setIsOpen(true);
    window.addEventListener('vnc-open-chatbot', handleOpenChat);
    return () => window.removeEventListener('vnc-open-chatbot', handleOpenChat);
  }, []);

  const handleAsk = async (e) => {
    e.preventDefault();
    if (!question.trim()) return;
    
    const currentQ = question;
    setQuestion('');
    
    // Cập nhật câu hỏi của người dùng vào giao diện trước
    setHistory(current => [...current, { question: currentQ, answer: null }]);
    setLoading(true);
    
    try {
      if (!chatSessionRef.current) {
         throw new Error("Phiên trò chuyện chưa được khởi tạo. Vui lòng kiểm tra lại khóa API.");
      }
      
      const result = await chatSessionRef.current.sendMessage(currentQ);
      const answer = result.response.text();
      
      // Update câu trả lời của AI
      setHistory(current => {
        const newHistory = [...current];
        newHistory[newHistory.length - 1].answer = answer || "Xin lỗi, tôi không thể trả lời câu hỏi này.";
        return newHistory;
      });
    } catch (err) {
      console.error(err);
      setHistory(current => {
        const newHistory = [...current];
        newHistory[newHistory.length - 1].answer = "Đã có lỗi xảy ra khi kết nối với trợ lý văn hóa AI. " + err.message;
        return newHistory;
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      {/* Floating Button with Enhanced Design */}
      <button className="global-chatbot-btn" onClick={toggleChat} aria-label="Mở Chatbot AI">
        <FaRobot size={30} />
      </button>

      {/* Chat Window with Premium Look */}
      {isOpen && (
        <div className="global-chatbot-window box-fade-in">
          <div className="gc-header">
            <div className="gc-header-info">
              <div className="gc-header-avatar">
                <FaRobot />
              </div>
              <div className="gc-header-text">
                <h4>Trợ lý Văn hóa Việt</h4>
                <span>Đại sứ văn hóa số</span>
              </div>
            </div>
            <button className="gc-close-btn" onClick={toggleChat}>
              <FaTimes />
            </button>
          </div>

          <div className="gc-messages">
            {history.length === 0 && (
              <div className="gc-message-wrapper assistant">
                <div className="gc-avatar-small"><RiDoubleQuotesL /></div>
                <div className="gc-message assistant">
                  Kính chào quý khách. Rất hân hạnh được đón tiếp bạn trong không gian của văn hóa Việt Nam. Chúc bạn một ngày an yên. Bạn muốn tìm hiểu về phong tục, ẩm thực hay di sản nào của đất nước chúng ta hôm nay?
                </div>
              </div>
            )}
            {history.map((msg, idx) => (
              <React.Fragment key={idx}>
                <div className="gc-message-wrapper user">
                  <div className="gc-message user">{msg.question}</div>
                </div>
                {msg.answer && (
                   <div className="gc-message-wrapper assistant">
                     <div className="gc-avatar-small"><FaRobot /></div>
                     <div className="gc-message assistant" style={{ whiteSpace: 'pre-line'}}>
                       {msg.answer}
                     </div>
                   </div>
                )}
              </React.Fragment>
            ))}
            {loading && (
              <div className="gc-message-wrapper assistant">
                <div className="gc-avatar-small"><FaRobot /></div>
                <div className="gc-message assistant loading">...</div>
              </div>
            )}
            <div ref={messagesEndRef} />
          </div>

          <form className="gc-input-area" onSubmit={handleAsk}>
            <input 
              type="text" 
              placeholder="Hỏi chuyên gia văn hóa..." 
              value={question}
              onChange={e => setQuestion(e.target.value)}
              disabled={loading}
            />
            <button type="submit" disabled={loading || !question.trim()}>
               <FaPaperPlane />
            </button>
          </form>
        </div>
      )}
    </>
  );
}
