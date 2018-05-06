import java.util.*;

class Modifier<T> {
  public Modifier() {}
  public T Call(T prev, double param) {
    return prev;
  }
}

class Keyframe {
  public int toNext;
  public double number;
  public Keyframe(int toNext, double number) {
    this.toNext = toNext;
    this.number = number;
  }
}

class Property<T> {
  ArrayList<Keyframe> values;
  public String name;
  Modifier<T> transform;
  public Property(String name, Modifier<T> mod, double value) {
    this.transform = mod;
    this.values = new ArrayList<Keyframe>();
    this.values.add(new Keyframe(0,value));
    this.name = name;
  }
  public Property(String name, Modifier<T> mod) {
    this.transform = mod;
    this.values = new ArrayList<Keyframe>();
    this.values.add(new Keyframe(0,0.0));
    this.name = name;
  }
  public void Key(int frame, double value) {
    int i = 0;
    int l = 0;
    for (; i < values.size(); i++) {
      l += values.get(i).toNext;
      if (l > frame) {
        break;
      }
    }
    if (i == values.size() - 1) {
      this.values.add(new Keyframe(frame - l, value));
      return;
    }
    this.values.get(i-1).toNext = frame - (l - this.values.get(i-1).toNext);
    this.values.add(i,new Keyframe(l - frame, value));
  }
  public ArrayList<Double> Render() {
    ArrayList<Double> temp = new ArrayList<Double>();
    double counter = 0;
    for (Keyframe k : values) {
      for (int i = 0; i < k.toNext; i++) {
        temp.add(Lerp(counter, counter + k.number, i / k.toNext));
      }
      counter += k.number;
    }
    return temp;
  }
  public double Lerp(double a, double b, double c) {
    return a + c * (b - a);
  }
}

class Layer<T> {
  T identity;
  ArrayList<Property> properties;
  public Layer(ArrayList<Property> props) {
    properties = props;
  }
  public void Key(String name, int frame, double value) {
    Property prop = this.properties.get(0);
    for (Property i : this.properties) {
      if (i.name == name) {
        prop = i;
      }
    }
    prop.Key(frame, value);
  }
  public ArrayList<T> Render(T start) {
    HashMap<String,ArrayList<Double>> vals = new HashMap<String,ArrayList<Double>>();
    //construct
    for(Property i : properties) {
      vals.put(i.name,i.Render());
    }
    //helper
    int max = -1;
    for(String i : vals.keySet()) {
      if(vals.get(i).size() > max) {
        max = vals.get(i).size();
      }
    }
    //apply
    ArrayList<T> answer = new ArrayList<T>();
    for (int i = 0; i < max; i++) {
      answer.add(start);
    }
    for (String s : vals.keySet()) {
      for (int i = 0; i < vals.get(s).size(); i++) {
        double val = vals.get(s).get(i);
        Property p = properties.get(0);
        for (Property h : properties) {
          if (h.name == s) {
            p = h;
          }
        }
        answer.set(i, (T)p.transform.Call((T)answer.get(i),val));
      }
    }
    return answer;
  }
}