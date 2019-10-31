require 'rails_helper'

describe 'タスク管理機能', type: :system do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
    let!(:blog_a) { FactoryBot.create(:blog, name: '最初のタスク', user: user_a) }
    
    before do
        # login_userをletで最初に定義しておく。
        # ユーザーAを作成しておく
        # user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')

        # 最初にlet!で登録しておく。
        # 作成者がユーザーAであるタスクを作成しておく
        # FactoryBot.create(:blog, name: '最初のタスク', user: user_a)

        visit login_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログインする'
    end

    # 下記のコードで共通化
    shared_examples_for 'ユーザーAが作成したタスクが表示される' do
        it { expect(page).to have_content '最初のタスク' }
    end
    
    describe '一覧表示機能' do
        context 'ユーザーAがログインしているとき' do
            let(:login_user) { user_a }
            # 下記を、１つ上の階層のbeforeに記述し、'ユーザーBがログインしているとき'の処理と共通化。
            # before do
            #     # ユーザーAでログインする
            #     visit login_path
            #     fill_in 'メールアドレス', with: 'a@example.com'
            #     fill_in 'パスワード', with: 'password'
            #     click_button 'ログインする'
            # end

            # 下記のコードをshared_examplesのコードで共通化
            # it 'ユーザーAが作成したタスクが表示される' do
            #     # 作成済みのタスクの名称が画面上に表示されていることを確認
            #     expect(page).to have_content '最初のタスク'
            # end
            it_behaves_like 'ユーザーAが作成したタスクが表示される'
        end

        context 'ユーザーBがログインしているとき' do
            let(:login_user) { user_b }

            # 下記を、１つ上の階層のbeforeに記述し、'ユーザーAがログインしているとき'の処理と共通化。
            # before do
            #     # ユーザーBを作成しておく
            #     FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
            #     # ユーザーBでログインする
            #     visit login_path
            #     fill_in 'メールアドレス', with: 'b@example.com'
            #     fill_in 'パスワード', with: 'password'
            #     click_button 'ログインする'
            # end

            # login_userをletで最初に定義しておく。
            # before do
            #     FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
            # end

            it 'ユーザーAが作成したタスクが表示されない' do
                # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
                expect(page).to have_no_content '最初のタスク'
            end
        end
    end

    describe '詳細表示機能' do
        context 'ユーザーAがログインしているとき' do
            let(:login_user) { user_a }

            before do
                visit blog_path(blog_a)
            end

            # 下記のコードをshared_examplesのコードで共通化
            # it 'ユーザーAが作成したタスクが表示される' do
            #     expect(page).to have_content '最初のタスク'
            # end
            it_behaves_like 'ユーザーAが作成したタスクが表示される'
        end
    end
end