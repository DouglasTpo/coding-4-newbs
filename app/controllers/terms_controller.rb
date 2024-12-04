class TermsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index], unless: :skip_pundit?

  def index
    @terms = policy_scope(Term)
  end

  def show
    authorize @term
  end

  def new
    @term = Term.new
    authorize @term
  end

  def create
    @term = Term.new(term_params)
    authorize @term
    if @term.save
      redirect_to @term, notice: 'Term was successfully created.'
    else
      render :new
    end
  end


  def home
  end

  def edit
    authorize @term
  end

  def update
    authorize @term
    if @term.update(term_params)
      redirect_to @term, notice: 'Term was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @term
    @term.destroy
    redirect_to terms_path, notice: 'Term was successfully deleted.'
  end

  private

  def set_term
    @term = Term.find(params[:id])
  end

  def term_params
    params.require(:term).permit(:name, :description)
  end
end
