### Generate header
echo "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
echo "<graph id=\"0\" label=\"9\" directed=\"1\" cy:documentVersion=\"3.0\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:cy=\"http://www.cytoscape.org\" xmlns=\"http://www.cs.rpi.edu/XGMML\">"

### Nodes
  cat down-node.txt|while read line
do
  pdb=`echo $line | awk '{print $1}'` ### RNA name (node)
  num=`echo $line | awk '{print $2}'` ### RNA ID number
  color=`echo $line | awk '{print $3}'` ### Color of the node (RGB code)
  shape=`echo $line | awk '{print $4}'` ### Shape (see Cytoscape website for more details)
  #tmp1=`echo $line | awk '{print $5}'` ### type of the node (will not be used)
  #tmp2=`echo $line | awk '{print $6}'` ### degree of the node (will not be used)
  xp=`echo $line | awk '{print $7}'` ### x position of the node
  yp=`echo $line | awk '{print $8}'` ### y position of the node
  size=`echo $line | awk '{print $9}'` ### Size of the node

  echo "  <node id=\""$num"\" label=\""$pdb"\">"
  echo "    <att name=\"shared name\" value="\"$pdb"\" type=\"string\"/>"
  echo "    <att name=\"selected\" value=\"0\" type=\"boolean\"/>"
  echo "    <att name=\"name\" value=\""$pdb"\" type=\"string\"/>"
  echo "    <graphics outline=\""#$color"\" type=\"$shape\" y=\"$yp\" h=\"$size\" width=\"1.0\" w=\"$size\" x=\"$xp\" fill="\"#$color"\" z=\"0.0\">"
  echo "    </graphics>"
  echo  "\n"
  echo "  </node>"

done

### Edges
  cat down-edge.txt|while read line
do
  pdb1=`echo $line | awk '{print $1}'` ### 1st RNA name
  num1=`echo $line | awk '{print $2}'` ### 1st RNA ID number
  pdb2=`echo $line | awk '{print $3}'` ### 2nd RNA name
  num2=`echo $line | awk '{print $4}'` ### 2nd RNA ID number
  edge=`echo $line | awk '{print $5}'` ### strength of the link (e.g. correlation value)
  color=`echo $line | awk '{print $6}'` ### Color of the link (RGB code)

  echo "  <edge id=\"\" label=\"" $pdb1 \($edge\) $pdb2"\" source=\""$num1"\" target=\""$num2"\" cy:directed=\"1\">"
  echo "    <att name=\"interaction\" value=\""$edge"\" type=\"string\"/>"
  echo "    <att name=\"shared name\" value=\""$pdb1 \($edge\) $pdb2"\" type=\"string\"/>"
  echo "    <att name=\"selected\" value=\"0\" type=\"boolean\"/>"
  echo "    <att name=\"name\" value=\""$pdb1 \($edge\) $pdb2"\" type=\"string\"/>"
  echo "    <att name=\"shared interaction\" value=\""$edge"\" type=\"string\"/>"
  echo "    <graphics width=\"2.0\" fill=\""#$color"\">"
  echo "    </graphics>"
  echo "  </edge>"
  echo "\n"

done

### Generate tail
echo "</graph>"
