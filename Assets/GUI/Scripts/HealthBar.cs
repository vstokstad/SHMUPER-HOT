using UnityEngine;
using UnityEngine.UI;

public class HealthBar : MonoBehaviour {
   public static Slider slider;
   private float currentHealth;
   

   private void Awake(){
    slider =  GetComponent<Slider>();
    currentHealth = PlayerData.health;
    slider.value = currentHealth;
   }

   private void OnGUI(){
       slider.value = PlayerData.health;
   }
   
}
