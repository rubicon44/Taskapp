class BlogMailer < ApplicationMailer
    default from: 'taskleaf@example.com'

    def creation_email(blog)
        @blog = blog
        mail(
            subject: 'タスク作成完了メール',
            to: 'user@example.com',
            from: 'taskleaf@example.com'
        )
    end
end
