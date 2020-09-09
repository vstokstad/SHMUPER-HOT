using System;
using UnityEngine;

[CreateAssetMenu(fileName = "New Player Data", menuName = "Scriptables/PlayerData", order = 0)]
public class PlayerData : ScriptableObject {
    [Header("Statistics")] public float health = 3f;
    public float rechargeTime = 10f;

    [Header("Move")] [Range(4f, 12f)] public float maxSpeed = 10f;

    public float acceleration = 3f;

    [Header("Weapons")] public int plasmaAmmunition = 10;

    [NonSerialized] public float boostForce = 2f;
    [SerializeField] private float _rechargeTimer;
    private GameObject _shieldBubble;

    private void OnEnable(){
        _shieldBubble = GameObject.Find("Shield");
    }


//Called in PlayerMovement to recharge boost but also recharges plasma ammo and shield.
//TODO Call in a PlayerManager or Controller instead.
    public void RechargeTimer(){
        if (_rechargeTimer > 0f) {
            _rechargeTimer -= Time.fixedDeltaTime;
        }
        else if (_rechargeTimer <= 0f) {
            if (plasmaAmmunition != 10) plasmaAmmunition += 1;
            if (!_shieldBubble.activeSelf)
                _shieldBubble.SetActive(true);
            if (boostForce <= 2f) boostForce += Time.deltaTime;

            _rechargeTimer = rechargeTime;
        }
    }
}