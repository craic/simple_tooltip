class SimpleTooltipsController < ApplicationController
  
  # Add admin before_filter here - something like this (depends on your authorization solution)
  # This prevents regular users from modifying the help pages
  # before_filter admin?, :except => [ :tooltip_content ]
  
  # GET /simple_tooltips
  # GET /simple_tooltips.xml
  def index
    @simple_tooltips = SimpleTooltip.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @simple_tooltips }
    end
  end

  # GET /simple_tooltips/1
  # GET /simple_tooltips/1.xml
  def show
    @simple_tooltip = SimpleTooltip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @simple_tooltip }
    end
  end

  # GET /simple_tooltips/new
  # GET /simple_tooltips/new.xml
  def new
    @simple_tooltip = SimpleTooltip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @simple_tooltip }
    end
  end

  # GET /simple_tooltips/1/edit
  def edit
    @simple_tooltip = SimpleTooltip.find(params[:id])
  end

  # POST /simple_tooltips
  # POST /simple_tooltips.xml
  def create
    @simple_tooltip = SimpleTooltip.new(params[:simple_tooltip])

    respond_to do |format|
      if @simple_tooltip.save
        format.html { redirect_to(@simple_tooltip, :notice => 'SimpleTooltip was successfully created.') }
        format.xml  { render :xml => @simple_tooltip, :status => :created, :location => @simple_tooltip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @simple_tooltip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /simple_tooltips/1
  # PUT /simple_tooltips/1.xml
  def update
    @simple_tooltip = SimpleTooltip.find(params[:id])

    respond_to do |format|
      if @simple_tooltip.update_attributes(params[:simple_tooltip])
        format.html { redirect_to(@simple_tooltip, :notice => 'SimpleTooltip was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @simple_tooltip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /simple_tooltips/1
  # DELETE /simple_tooltips/1.xml
  def destroy
    @simple_tooltip = SimpleTooltip.find(params[:id])
    @simple_tooltip.destroy

    respond_to do |format|
      format.html { redirect_to(simple_tooltips_url) }
      format.xml  { head :ok }
    end
  end
  
  
  # fetch and return the content of the specified tooltip, taking into account user's locale where relevant
  def tooltip_content

    if params[:title]
    
      # find and display a specific tooltip
      @simple_tooltip = SimpleTooltip.from_title_and_locale(params[:title])

      if params[:js]
        if @simple_tooltip.blank?
          data = "Sorry... unable to find that help content"
        else
          data = @simple_tooltip.content_to_html
        end
        send_data(data, :type => 'text/plain', :disposition => 'inline')
      else  
        if @simple_tooltip.blank?
          flash[:notice] = "Sorry... unable to find that help content"
        end
      end
      
    else
      # should be impossible to get here
       flash[:notice] = "Sorry... no tooltip Title was provided"
    end  
  end
    
end
