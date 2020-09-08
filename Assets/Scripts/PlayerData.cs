using UnityEngine;

[CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptables/PlayerData", order = 0)]
public class PlayerData : ScriptableObject {
    [Header(header: "Statistics")] public float health = 3f;
    public float ShieldCount { get; } = 1f;
    public float boostTimer = 10f;

    [Header(header: "Move")] [Range(min: 4f, max: 12f)]
    public float maxSpeed = 10f;

    public float acceleration = 3f;
    [Range(min: 1f, max: 10f)] public float boostForce = 10f;
    public bool boostChargeFull = true;

    public void BoostTimer(){
        boostTimer -= Time.fixedDeltaTime;
        boostChargeFull = !(boostTimer > 0f);
        
    }


    [Header(header: "Weapons")]
    public int ammunition = 10;
}