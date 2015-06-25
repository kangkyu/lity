class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]	
  before_action :set_group, only: [:show, :edit, :update, :destroy]

	def index
		@groups = Group.all
		authorize @groups
	end

	def edit
		@group = Group.find(params[:id])
		# authorize @group
	end

	def update
		@group = Group.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path
		else
			render :edit
		end		
	end

	def new
		@group = Group.new
		@group.archives.new
		# authorize @group
		# authorize @group.archives
	end

	def create
		@group = Group.new(group_params)
		# authorize @group

		if @group.save
			@group.memberships.create(user_id: current_user.id, group_id: @group.id, group_role: "admin")
			redirect_to @group
		else
			render action: :new
		end
	end

	def show
		@group = Group.find(params[:id])
		# authorize @group
		@archive = Archive.new
		@membership = Membership.where(group_id: (params[:id]))
	end

	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		redirect_to groups_path
	end

	private
		def set_group
			@group = Group.find(params[:id])
			# authorize @group
		end

		def group_params
			params.require(:group).permit(:group_name, memberships_attributes: [:user_id, :group_id, :group_role])
		end
end