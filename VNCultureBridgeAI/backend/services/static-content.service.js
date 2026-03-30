const staticCopy = {
  vi: {
    hero: {
      badge: 'Chào mừng đến Việt Nam',
      title: 'Khám phá vẻ đẹp văn hóa Việt Nam',
      subtitle:
        'Hành trình qua lịch sử, vùng miền, dân tộc, lễ hội, ẩm thực và nghệ thuật Việt bằng trải nghiệm song ngữ trực quan.',
      primaryCta: 'Khám phá ngay',
      secondaryCta: 'Bắt đầu học',
    },
    intro: {
      title: 'Nền tảng văn hoá song ngữ cho người học quốc tế',
      body:
        'VNCultureBridge AI tổ chức tri thức văn hoá Việt Nam theo vùng miền, dân tộc và chủ đề để người dùng dễ hiểu, dễ khám phá và có thể hỏi AI theo đúng ngữ cảnh.',
    },
    stats: [
      { label: 'Nhóm dân tộc', value: '54+' },
      { label: 'Năm lịch sử', value: '4.000+' },
      { label: 'Vùng văn hoá', value: '5+' },
      { label: 'Lễ hội & di sản', value: '300+' },
    ],
    aiGuide: {
      badge: 'Hướng dẫn AI văn hoá',
      title: 'Hỏi AI để hiểu văn hoá Việt sâu hơn',
      body:
        'AI Guide giải thích nguồn gốc, ý nghĩa, khác biệt vùng miền và gợi ý nội dung liên quan dựa trên dữ liệu đã kiểm duyệt.',
      placeholder: 'Hỏi về Tết, áo dài, dân tộc H’Mông, múa rối nước...',
      button: 'Đặt câu hỏi',
      reset: 'Đặt lại',
      sample:
        'Xin chào! Tôi là trợ lý văn hoá Việt Nam. Bạn có thể hỏi về lễ hội, ẩm thực, dân tộc, nghệ thuật hoặc phong tục tập quán.',
    },
    footer: {
      description:
        'Kết nối người học, du khách và người yêu văn hoá với chiều sâu bản sắc Việt Nam.',
      columns: {
        explore: 'Khám phá',
        culture: 'Văn hoá',
        cuisine: 'Ẩm thực',
        resources: 'Tài nguyên',
      },
    },
  },
  en: {
    hero: {
      badge: 'Welcome to Vietnam',
      title: 'Discover the beauty of Vietnamese culture',
      subtitle:
        'Journey through history, regions, ethnic communities, festivals, cuisine, and arts with a visual bilingual experience.',
      primaryCta: 'Explore now',
      secondaryCta: 'Start learning',
    },
    intro: {
      title: 'A bilingual culture platform for international learners',
      body:
        'VNCultureBridge AI organizes Vietnamese cultural knowledge by region, ethnicity, and theme so international users can explore clearly and ask AI with the right context.',
    },
    stats: [
      { label: 'Ethnic groups', value: '54+' },
      { label: 'Years of history', value: '4,000+' },
      { label: 'Cultural zones', value: '5+' },
      { label: 'Festivals & heritage', value: '300+' },
    ],
    aiGuide: {
      badge: 'AI culture guide',
      title: 'Ask AI to explore Vietnamese culture',
      body:
        'The AI Guide explains origins, meanings, regional differences, and related recommendations using reviewed internal cultural knowledge.',
      placeholder: 'Ask about Tet, Ao Dai, Hmong culture, water puppetry...',
      button: 'Ask now',
      reset: 'Reset',
      sample:
        'Hello! I am your Vietnamese Culture AI Guide. Ask me about festivals, cuisine, ethnic groups, arts, or traditions.',
    },
    footer: {
      description:
        'Connecting learners, travelers, and enthusiasts with the depth of Vietnamese identity.',
      columns: {
        explore: 'Explore',
        culture: 'Culture',
        cuisine: 'Cuisine',
        resources: 'Resources',
      },
    },
  },
}

function getStaticContent(lang = 'vi') {
  return staticCopy[lang] || staticCopy.vi
}

module.exports = {
  getStaticContent,
}
